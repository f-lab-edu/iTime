//
//  BookmarkRepository.swift
//
//
//  Created by 이상헌 on 11/19/23.
//

import RxSwift

// MARK: - BookmarkRepository

public protocol BookmarkRepository {
  func updateBookmarks(with bookmarks: [Activity]) -> Single<Void>
  func appendBookmark(_ bookmark: Activity) -> Single<Void>
  func removeBookmark(_ bookmark: Activity) -> Single<Void>
  func bookmarks() -> Single<[Activity]>
}
