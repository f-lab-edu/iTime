//
//  BookmarkListInteractorTests.swift
//
//
//  Created by 이상헌 on 1/2/24.
//

import XCTest
import FeatureTestSupports
import RepositoryTestSupports
import Entities
@testable import StartImpl

final class BookmarkListInteractorTests: XCTestCase {
  
  private var sut: BookmarkListInteractor!
  private var bookmarkModelDataStream: BookmarkModelDataStream!
  private var bookmarkListPresenter: BookmarkListPresentableSpy!
  
  override func setUp() {
    bookmarkModelDataStream = BookmarkModelDataStream()
    bookmarkListPresenter = BookmarkListPresentableSpy()
    sut = BookmarkListInteractor(
      initialState: .init(),
      presenter: bookmarkListPresenter,
      bookmarkModelDataStream: bookmarkModelDataStream
    )
  }
  
  func test_loadBookmarkList() async throws {
    // Given
    let dummyBookmarks = DummyData.DummyBookmark.dummyBookmarksFour
    bookmarkModelDataStream.update(with: dummyBookmarks)
    
    // When
    sut.loadBookmarkList()
    
    // Then
    async let result = bookmarkModelDataStream.bookmarks.take(1).values
    let bookmark = try await result.first(where: { _ in true })
    XCTAssertNotNil(bookmark)
    XCTAssertEqual(bookmark!, dummyBookmarks)
    XCTAssertEqual(bookmarkListPresenter.reloadBookmarksCallCount, 1)
    XCTAssertEqual(bookmarkListPresenter.hiddenEmptyIfNeededCallCount, 1)
    XCTAssertEqual(bookmarkListPresenter.isHiddenProperty, true)
  }
  
  func test_loadEmptyBookmarkList() async throws {
    // Given
    bookmarkModelDataStream.update(with: [])
    
    // When
    sut.loadBookmarkList()
    
    // Then
    async let result = bookmarkModelDataStream.bookmarks.take(1).values
    let bookmark = try await result.first(where: { _ in true })
    XCTAssertNotNil(bookmark)
    XCTAssertTrue(bookmark!.isEmpty)
    XCTAssertEqual(bookmarkListPresenter.reloadBookmarksCallCount, 1)
    XCTAssertEqual(bookmarkListPresenter.hiddenEmptyIfNeededCallCount, 1)
    XCTAssertEqual(bookmarkListPresenter.isHiddenProperty, false)
  }
  
  func test_numberOfItems() async throws {
    // Given
    let dummyBookmarks = DummyData.DummyBookmark.dummyBookmarksFour
    bookmarkModelDataStream.update(with: dummyBookmarks)
    sut.loadBookmarkList()
    async let _ = bookmarkModelDataStream.bookmarks.values
    
    // When
    let result = sut.numberOfItems()
    
    // Then
    XCTAssertEqual(result, dummyBookmarks.count)
  }
  
  func test_bookmark() async {
    // Given
    let dummyBookmarks = DummyData.DummyBookmark.dummyBookmarksFour
    bookmarkModelDataStream.update(with: dummyBookmarks)
    sut.loadBookmarkList()
    async let _ = bookmarkModelDataStream.bookmarks.values
    
    // When
    let bookmarkTitle = sut.bookmark(at: 0)
    
    // Then
    XCTAssertEqual(bookmarkTitle, dummyBookmarks[0].title)
  }
  
}
