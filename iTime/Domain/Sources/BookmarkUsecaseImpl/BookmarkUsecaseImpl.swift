//
//  File.swift
//  
//
//  Created by 이상헌 on 11/19/23.
//

import RxSwift

import BookmarkUsecase

final class BookmarkUsecaseImpl: BookmarkUsecase {
  
  // TODO: Repository 개발 후 반영
  private let bookmarkRepository: Any
  
  init(bookmarkRepository: Any) {
    self.bookmarkRepository = bookmarkRepository
  }
  
  func updateBookmarks() -> Single<Void> {
    .never()
  }
  
  func appendBookmark() -> Single<Void> {
    .never()
  }
  
  func removeBookmark() -> Single<Void> {
    .never()
  }
  
  func bookmarks() -> Single<[Bookmark]> {
    .never()
  }
}
