//
//  BookmarkListViewControllerTests.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import XCTest
import SharedUI
import FeatureTestSupports
@testable import StartImpl

final class BookmarkListViewControllerTests: XCTestCase {

  private var sut: BookmarkListViewController!
  private var bookmarkListPresentableListener: BookmarkListPresentableListenerSpy!
  
  override func setUp() {
    sut = BookmarkListViewController(
      alignedCollectionViewFlowLayout: LeadingAlignedCollectionViewFlowLayout(),
      cellBorderColor: .black10,
      emptyLabelText: "empty",
      emptyTextAlignment: .center
    )
    sut.listener = bookmarkListPresentableListener
  }
  
  func test_snapshot_when_presentError() { // TODO:
    // Given
    
    // When
    
    // Then
  }
  
  func test_snapshot_when_hiddenEmptyIfNeeded() { // TODO:
    // Given
    
    // When
    
    // Then
  }
  
  func test_snapshot_when_reloadBookmarks() { // TODO:
    // Given
    
    // When
    
    // Then
  }

}
