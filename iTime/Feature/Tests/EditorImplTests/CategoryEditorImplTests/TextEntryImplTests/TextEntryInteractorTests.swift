//
//  TextEntryInteractorTests.swift
//  
//
//  Created by 이상헌 on 3/12/24.
//

import XCTest
import Editor
import FeatureTestSupports
@testable import EditorImpl

final class TextEntryInteractorTests: XCTestCase {

  private var listener: TextEntryListenerSpy!
  private var presenter: TextEntryPresenterSpy!
  
  override func setUp() {
    listener = TextEntryListenerSpy()
    presenter = TextEntryPresenterSpy()
  }
  
  // Let's TDD!
  
  func test_loadData_withCategoryStringTitle_callupdateCategoryTextFieldWithTitle() {
    // Given
    let stringCategoryText = "운동"
    
    // When
    makeSUT(.init(currentCategoryText: stringCategoryText)).loadData()
    
    // Then
    XCTAssertEqual(presenter.updateCategoryTextFieldCallCount, 1)
    XCTAssertEqual(presenter.updateCategoryTextFieldPassedText, stringCategoryText)
  }
  
  func test_loadData_withCategoryEmojiTitle_callUpdateCategoryTextFieldWithTitle() {
    // Given
    let emojiCategoryText = "🤦🤦🤦"
    
    // When
    makeSUT(.init(currentCategoryText: emojiCategoryText)).loadData()
    
    // Then
    XCTAssertEqual(presenter.updateCategoryTextFieldCallCount, 1)
    XCTAssertEqual(presenter.updateCategoryTextFieldPassedText, emojiCategoryText)
  }
  
  func test_loadData_withSpacesTitle_callUpdateCategoryTextFieldWithTitle() {
    // Given
    let spacesCategoryText = "   "
    
    // When
    makeSUT(.init(currentCategoryText: spacesCategoryText)).loadData()
    
    // Then
    XCTAssertEqual(presenter.updateCategoryTextFieldCallCount, 1)
    XCTAssertEqual(presenter.updateCategoryTextFieldPassedText, spacesCategoryText)
  }
  
  func test_loadData_withValidCountTitle_callUpdateCategoryTextFieldWithTitle() {
    // Given
    let validCountCategoryText = "1234"
    
    // When
    makeSUT(.init(currentCategoryText: validCountCategoryText)).loadData()
    
    // Then
    XCTAssertEqual(presenter.updateCategoryTextFieldCallCount, 1)
    XCTAssertEqual(presenter.updateCategoryTextFieldPassedText, validCountCategoryText)
  }
  
  func test_loadData_withInvalidCountTitle_callUpdateCategoryTextFieldWithTitle() {
    // Given
    let invalidCategoryText = "123456789"
    
    // When
    makeSUT(.init(currentCategoryText: invalidCategoryText)).loadData()
    
    // Then
    XCTAssertEqual(presenter.updateCategoryTextFieldCallCount, 1)
    XCTAssertEqual(presenter.updateCategoryTextFieldPassedText, invalidCategoryText)
  }
  
  func test_didChageCategoryTextField_withText_() {
    
  }
  
  // MARK: - Helper
  
  private func makeSUT(_ state: TextEntryState) -> TextEntryInteractor {
    let sut = TextEntryInteractor(
      initalState: state,
      presenter: presenter
    )
    sut.listener = listener
    return sut
  }
  
}
