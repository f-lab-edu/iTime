//
//  BookmarkRepository.swift
//
//
//  Created by 이상헌 on 11/19/23.
//

import RxSwift

public protocol BookmarkRepository {
  func updateBookmarks(with bookmarks: [Bookmark]) -> Single<Void>
  func appendBookmark(_ bookmark: Bookmark) -> Single<Void>
  func removeBookmark(_ bookmark: Bookmark) -> Single<Void>
  func bookmarks() -> Single<[Bookmark]>
}
