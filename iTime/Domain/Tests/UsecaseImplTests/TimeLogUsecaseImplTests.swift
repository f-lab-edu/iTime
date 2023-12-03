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
  private var mutableBookmarkModelDataStream: MutableBookmarkModelDataStreamMock!
  private var mutableTimeLogRecordModelDataStream: MutableTimeLogRecordModelDataStreamMock!
  
  private var disposeBag: DisposeBag!
  private var scheduler: TestScheduler!
  
  override func setUp() {
    disposeBag = DisposeBag()
    scheduler = TestScheduler(initialClock: 0)
    
    bookmarkRepository = BookmarkRepositoryMock()
    timeLogRecordRepository = TimeLogRecordRepositoryMock()
    mutableBookmarkModelDataStream = MutableBookmarkModelDataStreamMock()
    mutableTimeLogRecordModelDataStream = MutableTimeLogRecordModelDataStreamMock()
    
    sut = TimeLogUsecaseImpl(
      bookmarkRepository: bookmarkRepository,
      timeLogRecordRepository: timeLogRecordRepository,
      mutableBookmarkModelDataStream: mutableBookmarkModelDataStream,
      mutableTimeLogRecordModelDataStream: mutableTimeLogRecordModelDataStream
    )
  }
  
  func test_preLoadAllData() {
    // When & Then
    _ = sut.preLoadAllData()
      .subscribe { result in
        switch result {
        case .success:
          XCTAssertEqual(self.bookmarkRepository.bookmarksCallcount, 1)
          XCTAssertEqual(self.timeLogRecordRepository.timeLogRecordsCallCount, 1)
          XCTAssertEqual(self.mutableBookmarkModelDataStream.updateCallCount, 1)
          XCTAssertEqual(self.mutableTimeLogRecordModelDataStream.updateRecordsCallCount, 1)
        case .failure:
          XCTFail()
        }
      }
  }
  
}
