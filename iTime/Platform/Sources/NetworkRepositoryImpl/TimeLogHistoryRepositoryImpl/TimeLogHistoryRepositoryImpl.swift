//
//  File.swift
//  
//
//  Created by 이상헌 on 11/26/23.
//

import RxSwift

import NetworkRepository
import LocalDataBaseRepository

import AppFoundation

public final class TimeLogHistoryRepositoryImpl: TimeLogHistoryRepository {
  
  // MARK: - DocumentReferenceConvertible
  
  private enum DatabaseReference: DocumentReferenceConvertible {
    case timeLogHistorySession(userID: String)
    
    var referencePath: String {
      switch self {
      case let .timeLogHistorySession(userID):
        return "\(DatabaseEndpoint.userSession.rawValue)/\(userID)/\(DatabaseEndpoint.timeLogHistorySession.rawValue)/timeloghistory"
      }
    }
  }
  
  // MARK: - Properties
  
  private let firestoreRepository: FirestoreRepository
  private let userDefaultRepository: ReadOnlyUserIDRepository
  
  // MARK: - Initialization
  
  public init(
    firestoreRepository: FirestoreRepository,
    userDefaultRepository: ReadOnlyUserIDRepository
  ) {
    self.firestoreRepository = firestoreRepository
    self.userDefaultRepository = userDefaultRepository
  }

  public func append(_ history: TimeLogHistory) -> Single<Void> {
    timeLogHistories()
      .map { $0 + [history] }
      .flatMap { [weak self] histories in
        guard let self else { return .error(MyError.networkNullError)}
        return self.update(with: histories)
      }
  }
  
  public func remove(with logID: String) -> Single<Void> {
    return .never()
  }
  
  public func timeLogHistories() -> Single<[TimeLogHistory]> {
    let timeLogHistoryList: Single<TimeLogHistoryList> =
    firestoreRepository.documentObservable(
      for: DatabaseReference.timeLogHistorySession(userID: userDefaultRepository.userID()),
      includeMetadata: false
    )
    .compactMap { try $0.decode() }
    .take(1) // https://github.com/ReactiveX/RxSwift/issues/1654
    .asSingle()
    
    return timeLogHistoryList.map(\.timeLogHistories)
  }
  
  // MARK: - Private
  
  private func update(with histories: [TimeLogHistory]) -> Single<Void> {
    firestoreRepository.update(
      reference: DatabaseReference.timeLogHistorySession(userID: userDefaultRepository.userID()),
      with: TimeLogHistoryList(histories).toJson() ?? [:],
      merge: false
    )
    .take(1) // https://github.com/ReactiveX/RxSwift/issues/1654
    .asSingle()
    .map { _ in Void() }
  }
  
}
