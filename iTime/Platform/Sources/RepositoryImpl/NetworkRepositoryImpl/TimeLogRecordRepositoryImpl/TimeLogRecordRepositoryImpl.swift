//
//  File.swift
//  
//
//  Created by 이상헌 on 11/26/23.
//

import RxSwift

import Models
import Entities
import Translator
import Repository
import BaseRepository

import AppFoundation

public final class TimeLogRecordRepositoryImpl: TimeLogRecordRepository {
  
  // MARK: - DocumentReferenceConvertible
  
  private enum DatabaseReference: DocumentReferenceConvertible {
    case timeLogHistorySession(userID: String)
    
    var referencePath: String {
      switch self {
      case let .timeLogHistorySession(userID):
        return "\(DatabaseEndpoint.userSession.rawValue)/\(userID)/\(DatabaseEndpoint.timeLogHistorySession.rawValue)/timelogrecord"
      }
    }
  }
  
  // MARK: - Properties
  
  private let firestoreRepository: FirestoreRepository
  private let userDefaultRepository: ReadOnlyUserIDRepository
  private let translator: TimeLogRecordTranslator
  
  // MARK: - Initialization
  
  public init(
    firestoreRepository: FirestoreRepository,
    userDefaultRepository: ReadOnlyUserIDRepository,
    translator: TimeLogRecordTranslator
  ) {
    self.firestoreRepository = firestoreRepository
    self.userDefaultRepository = userDefaultRepository
    self.translator = translator
  }
  
  public func update(with records: [TimeLogRecord]) -> Single<[TimeLogRecord]> {
    firestoreRepository.update(
      reference: DatabaseReference.timeLogHistorySession(userID: userDefaultRepository.userID()),
      with: translator.translateToTimeLogList(by: records).toJson() ?? [:],
      merge: false
    )
    .withUnretained(self)
    .flatMap { owner, _ in owner.timeLogRecords() }
    .take(1) // https://github.com/ReactiveX/RxSwift/issues/1654
    .asSingle()
  }

  public func append(_ record: TimeLogRecord) -> Single<[TimeLogRecord]> {
    timeLogRecords()
      .map { $0 + [record] }
      .flatMap { [weak self] records in
        guard let self else { return .error(MyError.networkNullError)}
        return self.update(with: records)
      }
  }
  
  public func remove(with logID: String) -> Single<[TimeLogRecord]> {
    timeLogRecords()
      .map {  $0.filter { $0.id != logID } }
      .flatMap { [weak self] records in
        guard let self else { return .error(MyError.networkNullError)}
        return self.update(with: records)
      }
  }
  
  public func timeLogRecords() -> Single<[TimeLogRecord]> {
    let timeLogHistoryList: Single<TimeLogList> =
    firestoreRepository.documentObservable(
      for: DatabaseReference.timeLogHistorySession(userID: userDefaultRepository.userID()),
      includeMetadata: false
    )
    .map { try $0.decode() ?? .init([]) }
    .ifEmpty(default: TimeLogList([]))
    .take(1) // https://github.com/ReactiveX/RxSwift/issues/1654
    .asSingle()
    
    return timeLogHistoryList
      .map(\.timeLogs)
      .map(translator.translateToTimeLogRecords(by:))
  }
}
