//
//  LogEntryCreationInteractorTests.swift
//
//
//  Created by 이상헌 on 12/8/23.
//

import XCTest
import RxTest

import Start
import Entities
import RepositoryTestSupports
@testable import StartImpl

final class LogEntryCreationInteractorTests: XCTestCase {
  
  private var sut: LogEntryCreationInteractor!
  private var presenter: LogEntryCreationPresentableSpy!
  private var bookmarkModelDataStream: BookmarkModelDataStreamImpl!
  private var scheduler: TestScheduler!

  override func setUp() {
    
    presenter = LogEntryCreationPresentableSpy()
    bookmarkModelDataStream = BookmarkModelDataStreamImpl()
    scheduler = TestScheduler(initialClock: 0)
    
    sut = LogEntryCreationInteractor(
      initialState: .init(),
      presenter: presenter,
      bookmarkModelDataStream: BookmarkModelDataStreamImpl()
    )
  }
  
  func test_before_active_set_listener() throws {
    // When
    sut.activate()
    
    // Then
    XCTAssertEqual(presenter.listenerSetCallCount, 1)
  }
  
  func test_loadDataAction_Into_BookmarksState() throws {
    // given
    let dummyBookmarks = DummyData.DummyBookmark.dummyBookmarksFour
    bookmarkModelDataStream.update(with: dummyBookmarks)
    
    scheduler.scheduleAt(1) {
      
    }
    
    
    
    
  }
  
}
