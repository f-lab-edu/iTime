//
//  ColorPickerInteractorTests.swift
//  
//
//  Created by 이상헌 on 3/10/24.
//

import XCTest
import Editor
import FeatureTestSupports
@testable import EditorImpl

final class ColorPickerInteractorTests: XCTestCase {
  
  private var listener: ColorPickerListenerSpy!
  
  override func setUp() {
    listener = ColorPickerListenerSpy()
  }
  
  func test_didTapColorButton_withFourIndex_stateCategoryColors() {
    // Given
    let index = 4
    let sut = makeSUT()
    
    // When
    sut.didTapColorButton(4)
    
    // Then
    XCTAssertEqual(sut.state.categoryColors, CategoryColors.greenblue)
  }
  
  func test_didTapColorbutton_withFourIndex_listenerCallCurrentCategoryColorHexWithEmpty() {
    // Given
    let index = 4
    
    // When
    makeSUT().didTapColorButton(4)
    
    // Then
    XCTAssertEqual(listener.currentCategoryColorHexCallCount, 1)
    XCTAssertTrue(listener.passedHex.isEmpty)
  }
  
  func test_didTapColorbutton_withFourIndexGrayHex_listenerCallCurrentCategoryColorHexWithHex() {
    // Given
    let index = 4
    let grayHex = "808080"
    
    // When
    makeSUT().didTapColorButton(index, grayHex)
    
    // Then
    XCTAssertEqual(listener.currentCategoryColorHexCallCount, 1)
    XCTAssertEqual(listener.passedHex, grayHex)
  }
  
  func test_didTapColorButton_withFourIndex_firstButtonIsSelected() {
    // Given
    let index = 4
    let button0 = CategoryColorOptionButton()
    let button1 = CategoryColorOptionButton()
    let button2 = CategoryColorOptionButton()
    let button3 = CategoryColorOptionButton()
    let button4 = CategoryColorOptionButton()
    
    // When
    makeSUT(buttons: [button0, button1, button2 ,button3, button4]).didTapColorButton(index)
    
    // Then
    XCTAssertEqual(button4.isSelected, true)
  }
  
  func test_didTapColorButton_withZeroIndex_stateCategoryColorsIsGray() {
    // Given
    let index = 0
    let sut = makeSUT()
    
    // When
    sut.didTapColorButton(index)
    
    // Then
    XCTAssertEqual(sut.state.categoryColors, CategoryColors.gray)
  }
  
  func test_didTapColorButton_withZeroIndex_firstButtonIsSelected() {
    // Given
    let index = 0
    let button = CategoryColorOptionButton()
    
    // When
    makeSUT(buttons: [button]).didTapColorButton(index)
    
    // Then
    XCTAssertTrue(button.isSelected)
  }
  
  func test_didTapColorbutton_withZeroIndex_listenerCallCurrentCategoryColorHexWithEmpty() {
    // Given
    let index = 0
    
    // When
    makeSUT().didTapColorButton(index)
    
    // Then
    XCTAssertEqual(listener.currentCategoryColorHexCallCount, 1)
    XCTAssertTrue(listener.passedHex.isEmpty)
  }
  
  func test_didTapColorbutton_withZeroIndexAndGrayHex_listenerCallCurrentCategoryColorHexWithHex() {
    // Given
    let index = 0
    let grayHex = "808080"
    
    
    // When
    makeSUT().didTapColorButton(index,grayHex)
    
    // Then
    XCTAssertEqual(listener.currentCategoryColorHexCallCount, 1)
    XCTAssertEqual(listener.passedHex, grayHex)
  }
  
  func test_didTapColotButton_withInvalidIndex_notUpdateState() {
    // Given
    let index = -1
    let sut = makeSUT()
    
    // When
    sut.didTapColorButton(index)
    
    // Then
    XCTAssertEqual(sut.state.categoryColors, .unknown)
  }
  
  func test_didTapColorButton_withInvalidIndex_firstButtonIsNotSelected() {
    // Given
    let index = -1
    let button = CategoryColorOptionButton()
    
    // When
    makeSUT(buttons: [button]).didTapColorButton(index)
    
    // Then
    XCTAssertFalse(button.isSelected)
  }

  // MARK: - Helper
  
  private func makeSUT(buttons: [UIButton] = [], loadViewIfNeeded: Bool = false) -> ColorPickerInteractor {
    let viewController = ColorPickerViewController(buttons: buttons)
    if loadViewIfNeeded { viewController.loadViewIfNeeded() }
    let sut =  ColorPickerInteractor(
      initialState: .init(),
      presenter: viewController
    )
    sut.listener = listener
    return sut
  }
  
}
