//
//  File.swift
//  
//
//  Created by 이상헌 on 11/19/23.
//

import RxSwift

import BookmarkUsecase

final class BookmarkUsecaseImpl: BookmarkUsecase {
  typealias Item = Bookmark
  
  // TODO: Repository 개발 후 반영
  private let bookmarkRepository: Any
  
  init(bookmarkRepository: Any) {
    self.bookmarkRepository = bookmarkRepository
  }
  
  func update(by bookmarks: [Item]) -> Single<Void> {
    .never()
  }
  
  func append(by bookmark: Item) -> Single<Void> {
    .never()
  }
  
  func remove(by bookmark: Item) -> Single<Void> {
    .never()
  }
  
  func bookmarks() -> Single<[Item]> {
    .never()
  }
}
