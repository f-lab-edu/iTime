//
//  File.swift
//  
//
//  Created by 이상헌 on 12/3/23.
//

import RxSwift

import Entities

public final class MutableBookmarkModelDataStreamMock: MutableBookmarkModelDataStream {
  
  public var bookmarks: Observable<[Bookmark]> { .just([]) }
  
  public var updateCallCount: Int = 0
  public func update(with bookmarks: [Entities.Bookmark]) {
    updateCallCount += 1
  }
  
  public var appendCallCount: Int = 0
  public func append(_ bookmark: Entities.Bookmark) {
    appendCallCount += 1
  }
  
  public var removeCallCount: Int = 0
  public func remove(_ bookmark: Entities.Bookmark) {
    removeCallCount += 1
  }
  
  public init() {}
}

