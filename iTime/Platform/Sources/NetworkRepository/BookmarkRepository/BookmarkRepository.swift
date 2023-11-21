//
//  BookmarkRepository.swift
//
//
//  Created by 이상헌 on 11/19/23.
//

import RxSwift

public protocol BookmarkRepository {
  func updateBookmarks(with bookmarks: [Bookmark], for userID: String) -> Single<Void>
  func appendBookmark(_ bookmark: Bookmark, for userID: String) -> Single<Void>
  func removeBookmark(_ bookmark: Bookmark, for userID: String) -> Single<Void>
  func bookmarks(for userID: String) -> Single<[Bookmark]>
}
