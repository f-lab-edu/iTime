//
//  File.swift
//  
//
//  Created by 이상헌 on 12/3/23.
//
import RxSwift

import Entities
import Repository
import RepositoryTestSupports

public final class BookmarkRepositoryMock: BookmarkRepository {
  
  public let dummy = DummyData.DummyBookmark.dummyBookmarksFour
  
  public var updateCallCount: Int = 0
  public var updatingBookmarks: [Bookmark] = []
  public func update(with bookmarks: [Entities.Bookmark]) -> RxSwift.Single<[Entities.Bookmark]> {
    updateCallCount += 1
    updatingBookmarks = bookmarks
    return .just([])
  }
  
  public var appendCallCount: Int = 0
  public func append(_ bookmark: Entities.Bookmark) -> RxSwift.Single<[Entities.Bookmark]> {
    appendCallCount += 1
    return .just([])
  }

  public var removeCallCount: Int = 0
  public func remove(_ bookmark: Entities.Bookmark) -> RxSwift.Single<[Entities.Bookmark]> {
    removeCallCount += 1
    return .just([])
  }
  
  public var bookmarksCallcount = 0
  public func bookmarks() -> RxSwift.Single<[Entities.Bookmark]> {
    bookmarksCallcount += 1
    return .just(dummy)
  }
  
  public init() {}
}
