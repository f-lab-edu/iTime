//
//  LogEntryCreationInteractorTests.swift
//
//
//  Created by 이상헌 on 12/8/23.
//

import XCTest
import RxSwift

import Entities
import RepositoryTestSupports
import ProxyTestSupport
@testable import StartImpl

final class LogEntryCreationInteractorTests: XCTestCase {
  
  private var sut: LogEntryCreationInteractor!
  private var presenter: LogEntryCreationPresentableSpy!
  private var bookmarkModelDataStream: BookmarkModelDataStreamImpl!
  private var router: LogEntryCreationRoutingSpy!
  private var listener: LogEntryCreationListenerSpy!
  private var disposeBag: DisposeBag!
  
  override func setUp() {
    
    presenter = LogEntryCreationPresentableSpy()
    bookmarkModelDataStream = BookmarkModelDataStreamImpl()
    router = LogEntryCreationRoutingSpy()
    listener = LogEntryCreationListenerSpy()
    disposeBag = DisposeBag()
    
    sut = LogEntryCreationInteractor(
      initialState: .init(),
      presenter: presenter,
      bookmarkModelDataStream: bookmarkModelDataStream
    )
    sut.router = router
    sut.listener = listener
  }
  
  func test_before_active_set_listener() throws {
    // When
    sut.activate()
    
    // Then
    XCTAssertEqual(presenter.listenerSetCallCount, 1)
  }
  
  func test_loadDataMutation() async throws {
    // Given
    let dummyBookmarks = DummyData.DummyBookmark.dummyBookmarksFour
    bookmarkModelDataStream.update(with: dummyBookmarks)
    
    // When
    async let stateValues = sut.state.take(1).values
    sut.activate()
    sut.sendAction(.loadData)
    
    // Then
    let targetState = try await stateValues.first(where: { _ in true })
    let bookmarks = targetState.map(\.bookmarks)?.compactMap { $0 }
    XCTAssertEqual(bookmarks, dummyBookmarks)
  }
  
  func test_didTapEncouragingBoxCloseButtonMutation() async throws {
    // When
    async let stateValues = sut.state.take(1).values
    sut.activate()
    sut.sendAction(.didTapEncouragingBoxCloseButton)
    
    // Then
    let targetState = try await stateValues.first(where: { _ in true })
    let isHiddenEncouragingBox = targetState.map(\.isHiddenEncouragingBox)!
    XCTAssertEqual(isHiddenEncouragingBox, true)
  }
  
  func test_didTapBookmarkTagEditorMutation() {
    // When
    sut.activate()
    sut.sendAction(.didTapBookmarkTagEditor)
    
    // Then
    XCTAssertEqual(router.attachBookmarkEditorRIbCallCount, 1)
  }
  
  func test_didTapEditorRoutingButtonMutation() {
    // When
    sut.activate()
    sut.sendAction(.didTapEditorRoutingButton)
    
    // Then
    XCTAssertEqual(router.attachLogEntryEditorRIBCallCount, 1)
  }
  
  func test_didTapStartButtonMutation() {
    // When
    sut.activate()
    sut.sendAction(.didTapStartButton)
    
    // Then
    XCTAssertEqual(router.attachTimeLogRunningRIBCallCount, 1)
  }
  
}
