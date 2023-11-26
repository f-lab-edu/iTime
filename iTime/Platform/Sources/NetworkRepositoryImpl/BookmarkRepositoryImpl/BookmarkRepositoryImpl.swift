//
//  BookmarkRepositoryImpl.swift
//
//
//  Created by 이상헌 on 11/19/23.
//

import RxSwift

import NetworkRepository
import LocalDataBaseRepository

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
  
  // MARK: - Initialization
  
  public init(
    firestoreRepository: FirestoreRepository,
    userDefaultRepository: ReadOnlyUserIDRepository
  ) {
    self.firestoreRepository = firestoreRepository
    self.userDefaultRepository = userDefaultRepository
  }
  
  // MARK: - Methods
  
  public func updateBookmarks(with bookmarks: [Activity]) -> Single<Void> {
    firestoreRepository.update(
      reference: DatabaseReference.bookmarkSession(userID: userDefaultRepository.userID()),
      with: BookmarkList(bookmarks).toJson() ?? [:] ,
      merge: false
    )
    .take(1) // https://github.com/ReactiveX/RxSwift/issues/1654
    .asSingle()
    .map { _ in Void() }
  }
  
  public func appendBookmark(_ bookmark: Activity) -> Single<Void> {
    bookmarks()
      .map { $0 + [bookmark] }
      .flatMap { [weak self] bookmarks in
        guard let self else { return .error(MyError.networkNullError)}
        return self.updateBookmarks(with: bookmarks)
      }
  }
  
  public func removeBookmark(_ bookmark: Activity) -> Single<Void> {
    bookmarks()
      .map {  $0.filter { $0.title != bookmark.title } }
      .flatMap { [weak self] bookmarks in
        guard let self else { return .error(MyError.networkNullError)}
        return self.updateBookmarks(with: bookmarks)
      }
  }
  
  public func bookmarks() -> Single<[Activity]> {
    let bookmarkList: Single<BookmarkList> =
    firestoreRepository.documentObservable(
      for: DatabaseReference.bookmarkSession(userID: userDefaultRepository.userID()),
      includeMetadata: false
    )
    .compactMap { try $0.decode() }
    .take(1) // https://github.com/ReactiveX/RxSwift/issues/1654
    .asSingle()
    
    return bookmarkList.map(\.bookmarks)
  }
  
}
