//
//  BookmarkRepositoryImpl.swift
//
//
//  Created by 이상헌 on 11/19/23.
//

import RxSwift

import NetworkRepository
import NetworkRepositoryImpl
import AppFoundation

public final class BookmarkRepositoryImpl: FirestoreRepository, BookmarkRepository {
  
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
  
  // MARK: - Methods
  
  public func updateBookmarks(with bookmarks: [Bookmark], for userID: String) -> Single<Void> {
    update(
      reference: DatabaseReference.bookmarkSession(userID: userID),
      with: BookmarkList(bookmarks).toJson() ?? [:] ,
      merge: false
    )
    .take(1) // https://github.com/ReactiveX/RxSwift/issues/1654
    .asSingle()
    .map { _ in Void() }
  }
  
  public func appendBookmark(_ bookmark: Bookmark, for userID: String) -> Single<Void> {
    bookmarks(for: userID)
      .map { $0 + [bookmark] }
      .flatMap { [weak self] bookmarks in
        guard let self else { return .error(MyError.networkNullError)}
        return self.updateBookmarks(with: bookmarks, for: userID)
      }
  }
  
  public func removeBookmark(_ bookmark: Bookmark, for userID: String) -> Single<Void> {
    bookmarks(for: userID)
      .map {  $0.filter { $0.title != bookmark.title } }
      .flatMap { [weak self] bookmarks in
        guard let self else { return .error(MyError.networkNullError)}
        return self.updateBookmarks(with: bookmarks, for: userID)
      }
  }
  
  public func bookmarks(for userID: String) -> Single<[Bookmark]> {
    let bookmarkList: Single<BookmarkList> =
    documentObservable(
      for: DatabaseReference.bookmarkSession(userID: userID),
      includeMetadata: false
    )
    .take(1) // https://github.com/ReactiveX/RxSwift/issues/1654
    .asSingle()
    .map { try! $0.decode()! }
    
    return bookmarkList.map(\.bookmarks)
  }
  
  public init() {}
  
}
