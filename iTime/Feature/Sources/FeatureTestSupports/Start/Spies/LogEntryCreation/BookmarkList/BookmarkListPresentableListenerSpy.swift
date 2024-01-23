//
//  File.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import Foundation
import StartImpl

public final class BookmarkListPresentableListenerSpy: BookmarkListPresentableListener {
  
  public var loadbookmarkListCallCount: Int = 0
  public func loadBookmarkList() {
    loadbookmarkListCallCount += 1
  }
  
  public var didTapTageCellIndex: IndexPath = .init()
  public var didTapTagCellCallCount: Int = 0
  public func didTapTagCell(at index: IndexPath) {
    didTapTageCellIndex = index
    didTapTagCellCallCount += 1
  }
  
  public var numberOfItemsCallCount: Int = 0
  public func numberOfItems() -> Int {
    numberOfItemsCallCount += 1
    return 10
  }
  
  public var bookmarkIndex: Int = 0
  public var bookmarkCallCount: Int = 0
  public func bookmark(at index: Int) -> String {
    bookmarkIndex += 1
    bookmarkCallCount += 1
    return "TEST"
  }
  
  public init() {}
}

