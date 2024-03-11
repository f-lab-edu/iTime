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
  
  // 테스트 이론 넣어보기.
  // 경계값. 4,5,6
  // 멘토링 통해 알게된 테스팅 개념 접목 하여 TC 작성 해보기
  
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
    XCTAssertEqual(button.isSelected, true)
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
  
  func test_didTapColotButton_withThreeIndexAndGreen_stateCategoryColors() {
    
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
