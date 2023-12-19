//
//  TimeLogUsecaseImplTests.swift
//
//
//  Created by 이상헌 on 12/3/23.
//
import XCTest

import RxSwift
import RxTest

import Entities
import Repository
import RepositoryTestSupports
import UsecaseTestSupports
import ProxyTestSupport
@testable import UsecaseImpl

final class TimeLogUsecaseImplTests: XCTestCase {
  
  private var sut: TimeLogUsecaseImpl!
  
  private var bookmarkRepository: BookmarkRepositoryMock!
  private var timeLogRecordRepository: TimeLogRecordRepositoryMock!
  private var bookmarkModelDataStreamImpl: BookmarkModelDataStream!
  private var timeLogRecordModelDataStreamImpl: TimeLogRecordModelDataStream!
  private var configuration: DummyDataConfiguration!
  private var disposeBag: DisposeBag!
  private var scheduler: TestScheduler!
  
  private var bookmarkSubject: PublishSubject<[Bookmark]>!
  private lazy var bookmarkObserver = scheduler.record(bookmarkSubject, disposeBag: disposeBag)
  private var timeLogRecordSubject: PublishSubject<[TimeLogRecord]>!
  private lazy var timeLogRecordObserver = scheduler.record(timeLogRecordSubject, disposeBag: disposeBag)
  
  override func setUp() {
    configuration = DummyDataConfiguration()
    disposeBag = DisposeBag()
    scheduler = TestScheduler(initialClock: 0)
  
    bookmarkRepository = BookmarkRepositoryMock()
    timeLogRecordRepository = TimeLogRecordRepositoryMock()
    bookmarkModelDataStreamImpl = BookmarkModelDataStream()
    timeLogRecordModelDataStreamImpl = TimeLogRecordModelDataStream()
    bookmarkSubject = .init()
    _ = bookmarkObserver
    timeLogRecordSubject = .init()
    _ = timeLogRecordObserver
    
    sut = TimeLogUsecaseImpl(
      bookmarkRepository: bookmarkRepository,
      timeLogRecordRepository: timeLogRecordRepository,
      bookmarkModelDataStream: bookmarkModelDataStreamImpl,
      timeLogRecordModelDataStream: timeLogRecordModelDataStreamImpl
    )
  }
  
  func test_when_preLoadAllData_bookmarkModelDataStream() {
    // Given
    let bookmarks = DummyData.DummyBookmark.dummyBookmarksFour
    bookmarkModelDataStreamImpl.update(with: bookmarks)
    
    // When
    scheduler.scheduleAt(1) {
      _ = self.sut.preLoadAllData().subscribe()
    }
    
    scheduler.scheduleAt(2) {
      _ = self.bookmarkModelDataStreamImpl.bookmarks
        .subscribe(onNext: { self.bookmarkSubject.onNext($0) })
    }
    
    // Then
    scheduler.start()
    
    XCTAssertEqual(bookmarkObserver.events, [
      .next(2, bookmarks),
    ])
  }
  
  func test_when_preLoadAllData_timeLogRecordModelDataStream() {
    // Given
    let timeLogRecords = DummyData.DummyTimeLogRecord.dummyTimeLogRecords
    timeLogRecordModelDataStreamImpl.updateRecords(with: timeLogRecords)
    
    // When
    scheduler.scheduleAt(1) {
      _ = self.sut.preLoadAllData().subscribe()
    }
    
    scheduler.scheduleAt(2) {
      _ = self.timeLogRecordModelDataStreamImpl.timeLogRecords
        .subscribe(onNext: { self.timeLogRecordSubject.onNext($0) })
    }
    
    // Then
    scheduler.start()
    
    XCTAssertEqual(timeLogRecordObserver.events, [
      .next(2, timeLogRecords),
    ])
  }
  
}
