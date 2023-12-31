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
import UsecaseTestSupports
import ProxyTestSupport
@testable import StartImpl

final class LogEntryCreationInteractorTests: XCTestCase {
  
  private var sut: LogEntryCreationInteractor!
  private var presenter: LogEntryCreationPresentableSpy!
  private var bookmarkModelDataStream: BookmarkModelDataStream!
  private var router: LogEntryCreationRoutingSpy!
  private var listener: LogEntryCreationListenerSpy!
  private var timerUsecase: TimerUsecaseMock!
  
  private var disposeBag: DisposeBag!
  
  override func setUp() {
    
    presenter = LogEntryCreationPresentableSpy()
    bookmarkModelDataStream = BookmarkModelDataStream()
    router = LogEntryCreationRoutingSpy()
    listener = LogEntryCreationListenerSpy()
    timerUsecase = TimerUsecaseMock()
    disposeBag = DisposeBag()
    
    sut = LogEntryCreationInteractor(
      presenter: presenter,
      bookmarkModelDataStream: bookmarkModelDataStream,
      timerUsecase: timerUsecase
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
  
  func test_didTapBookmarkTagEditor() {
    // When
    sut.activate()
    sut.didTapBookmarkTagEditor()
    
    // Then
    XCTAssertEqual(router.attachBookmarkEditorRIbCallCount, 1)
  }
  
  func test_didTapEditorRoutingButton() {
    // When
    sut.activate()
    sut.didTapEditorRoutingButton()
    
    // Then
    XCTAssertEqual(router.attachLogEntryEditorRIBCallCount, 1)
  }
  
  func test_didTapStartButton() {
    // When
    sut.activate()
    sut.didTapStartButton()
    
    // Then
    XCTAssertEqual(router.attachTimeLogRunningRIBCallCount, 1)
  }
  
}
