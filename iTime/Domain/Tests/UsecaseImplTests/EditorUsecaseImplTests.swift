//
//  EditorUsecaseImplTests.swift
//
//
//  Created by 이상헌 on 12/27/23.
//

import XCTest
import Entities
import RepositoryTestSupports
import UsecaseTestSupports
@testable import UsecaseImpl

final class EditorUsecaseImplTests: XCTestCase {
  
  private var sut: EditorUsecaseImpl!
  private var bookmarkModelDataStream: BookmarkModelDataStream!
  private var timeLogRecordModelDataStream: TimeLogRecordModelDataStream!
  private var bookmarkRepository: BookmarkRepositoryMock!
  private var timeLogRecordRepository: TimeLogRecordRepositoryMock!
  
  override func setUp() {
    bookmarkModelDataStream = BookmarkModelDataStream()
    timeLogRecordModelDataStream = TimeLogRecordModelDataStream()
    bookmarkRepository = BookmarkRepositoryMock()
    timeLogRecordRepository = TimeLogRecordRepositoryMock()
    sut = EditorUsecaseImpl(
      bookmarkModelDataStream: bookmarkModelDataStream,
      timeLogRecordModelDataStream: timeLogRecordModelDataStream,
      bookmarkRepository: bookmarkRepository,
      timeLogRecordRepository: timeLogRecordRepository
    )
  }
  
  func test_uploadBookmarks() async throws {
    // Given
    let dummyBookmarks = DummyData.DummyBookmark.dummyBookmarksFour
    bookmarkModelDataStream.update(with: dummyBookmarks)
    
    // When
    async let response = sut.uploadBookmarks().values
    
    // Then
    let _ = try await response.first(where: { _ in true })
    XCTAssertEqual(bookmarkRepository.updatingBookmarks, dummyBookmarks)
    XCTAssertEqual(bookmarkRepository.updateCallCount, 1)
  }
  
  func test_uploadTimeLogRecords() async throws {
    // Given
    let dummyTimeLogRecords = DummyData.DummyTimeLogRecord.dummyTimeLogRecords
    timeLogRecordModelDataStream.updateRecords(with: dummyTimeLogRecords)
    
    // When
    async let response = sut.uploadTimeLogRecord().values
    
    // Then
    let _ = try await response.first(where: { _ in true })
    XCTAssertEqual(timeLogRecordRepository.updatingRecords, dummyTimeLogRecords)
    XCTAssertEqual(timeLogRecordRepository.updateCallCount, 1)
  }
  
}
