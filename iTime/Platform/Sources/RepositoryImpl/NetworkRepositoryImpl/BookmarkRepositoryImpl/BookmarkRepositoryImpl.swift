//
//  BookmarkRepositoryImpl.swift
//
//
//  Created by 이상헌 on 11/19/23.
//

import RxSwift

import Models
import Entities
import Translator
import Repository
import BaseRepository

import AppFoundation

public final class BookmarkRepositoryImpl: BookmarkRepository {
  
  // MARK: - DocumentReferenceConvertible
  
  private enum DatabaseReference: DocumentReferenceConvertible {
    case bookmarkSession(userID: String)
    
    var referencePath: String {
      switch self {
      case let .bookmarkSession(userID):
        return "\(DatabaseEndpoint.userSession.rawValue)/\(userID)/\(DatabaseEndpoint.bookmarkSession.rawValue)/bookmarks"
      }
    }
  }
  
  // MARK: - Properties
  
  private let firestoreRepository: FirestoreRepository
  private let userDefaultRepository: ReadOnlyUserIDRepository
  private let translator: BookmarkTranslator
  
  // MARK: - Initialization
  
  public init(
    firestoreRepository: FirestoreRepository,
    userDefaultRepository: ReadOnlyUserIDRepository,
    translator: BookmarkTranslator
  ) {
    self.firestoreRepository = firestoreRepository
    self.userDefaultRepository = userDefaultRepository
    self.translator = translator
  }
  
  // MARK: - Methods
  
  public func update(with bookmarks: [Bookmark]) -> Single<[Bookmark]> {
    firestoreRepository.update(
      reference: DatabaseReference.bookmarkSession(userID: userDefaultRepository.userID()),
      with: translator.translateToPerformList(by: bookmarks).toJson() ?? [:] ,
      merge: false
    )
    .withUnretained(self)
    .flatMap { owner, _ in owner.bookmarks() }
    .take(1) // https://github.com/ReactiveX/RxSwift/issues/1654
    .asSingle()
  }
  
  public func append(_ bookmark: Bookmark) -> Single<[Bookmark]> {
    bookmarks()
      .map { $0 + [bookmark] }
      .flatMap { [weak self] bookmarks in
        guard let self else { return .error(MyError.networkNullError)}
        return self.update(with: bookmarks)
      }
  }
  
  public func remove(_ bookmark: Bookmark) -> Single<[Bookmark]> {
    bookmarks()
      .map { $0.filter { $0 != bookmark } }
      .flatMap { [weak self] bookmarks in
        guard let self else { return .error(MyError.networkNullError)}
        return self.update(with: bookmarks)
      }
  }
  
  public func bookmarks() -> Single<[Bookmark]> {
    let performList: Single<PerformList> =
    firestoreRepository.documentObservable(
      for: DatabaseReference.bookmarkSession(userID: userDefaultRepository.userID()),
      includeMetadata: false
    )
    .compactMap { try $0.decode() }
    .ifEmpty(default: PerformList([]))
    .take(1) // https://github.com/ReactiveX/RxSwift/issues/1654
    .asSingle()
    
    return performList
      .map(\.performs)
      .map(translator.translateToBookmarks(by:))
  }
  
}
