//
//  File.swift
//  
//
//  Created by 이상헌 on 11/19/23.
//

import RxSwift

// MARK: - BookmarkUsecase

public protocol BookmarkUsecase {
  func updateBookmarks() -> Single<Void>
  func appendBookmark() -> Single<Void>
  func removeBookmark() -> Single<Void>
  func bookmarks() -> Single<[Bookmark]>
}

