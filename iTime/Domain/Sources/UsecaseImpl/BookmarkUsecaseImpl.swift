//
//  File.swift
//
//
//  Created by 이상헌 on 11/19/23.
//

import RxSwift

import Usecase
import Entities

public final class BookmarkUsecaseImpl: BookmarkUsecase {
  
  // TODO: Repository 개발 후 반영
  private let bookmarkRepository: Any
  
  public init(bookmarkRepository: Any) {
    self.bookmarkRepository = bookmarkRepository
  }
  
  public func update(with bookmarks: [Bookmark]) -> Single<Void> {
    .never()
  }
  
  public func append(_ bookmark: Bookmark) -> Single<Void> {
    .never()
  }
  
  public func remove(_ bookmark: Bookmark) -> Single<Void> {
    .never()
  }
  
  public func bookmarks() -> Single<[Bookmark]> {
    .never()
  }
}
