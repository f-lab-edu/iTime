//
//  BookmarkEditorInteractorTests.swift
//  
//
//  Created by 이상헌 on 1/1/24.
//

import XCTest
import UsecaseTestSupports
import RepositoryTestSupports
import FeatureTestSupports
import Entities
@testable import EditorImpl

final class BookmarkEditorInteractorTests: XCTestCase {
  
  private var sut: BookmarkEditorInteractor!
  private var editorUsecase: EditorUsecaseMock!
  private var bookmarkEditorPresenter: BookmarkEditorPresenterSpy!
  private var bookmarkModelDataStream: BookmarkModelDataStream!
  private var bookmarkEditorListener: BookmarkEditorListenerSpy!
  
  override  func setUp() {
    bookmarkEditorListener = BookmarkEditorListenerSpy()
    bookmarkModelDataStream = BookmarkModelDataStream()
    bookmarkEditorPresenter = BookmarkEditorPresenterSpy()
    editorUsecase = EditorUsecaseMock()
    sut = BookmarkEditorInteractor(
      presenter: bookmarkEditorPresenter,
      bookmarkModelDataStream: bookmarkModelDataStream,
      editorUsecase: editorUsecase
    )
    sut.listener = bookmarkEditorListener
  }
  
  func test_didTapSaveButton() {
    // Given
    let exepectedBookmarks = DummyData.DummyBookmark.dummyBookmarksFour
    
    // When
    sut.didTapSaveButton()
    
    // Then
    XCTAssertEqual(editorUsecase.dummyBookmarks, exepectedBookmarks)
  }
  
  func test_didTapBackButton() {
    // When
    sut.didTapBackButton()
    
    // Then
    XCTAssertEqual(bookmarkEditorListener.detachBookmarkEditorRIBCallCount, 1)
  }
  
  func test_didTapTagCell() async throws {
    // Given
    let dummyBookmarks = DummyData.DummyBookmark.dummyBookmarksTwo
    bookmarkModelDataStream.update(with: dummyBookmarks)
    let willremoveBookmark = DummyData.DummyBookmark.dummyBookmarkOne
    
    // When
    sut.didTapTagCell(willremoveBookmark)
    
    // Then
    async let result = bookmarkModelDataStream.bookmarks.take(1).values
    let expectedBookmarks = try await result.first(where: { _ in true })
    XCTAssertNotNil(expectedBookmarks)
    XCTAssertEqual(expectedBookmarks!.count, 1)
  }

}
