//
//  ColorPickerInteractorTests.swift
//  
//
//  Created by 이상헌 on 3/10/24.
//

import XCTest
import Editor
@testable import EditorImpl

final class ColorPickerInteractorTests: XCTestCase {
  
  func test_didTapColorButton_withZeroIndex_stateCategoryColorsIsGray() {
    // Given
    let index = 0
    // let grayHex = "808080"
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
  
  func test_didTapColorbutton_withZeroIndexAndGray_listener() {
    
  }
  
  func test_didTapColotButton_withThreeIndexAndGreen_stateCategoryColors() {
    
  }
  
  private func makeSUT(buttons: [UIButton] = [], loadViewIfNeeded: Bool = false) -> ColorPickerInteractor {
    let viewController = ColorPickerViewController(buttons: buttons)
    if loadViewIfNeeded { viewController.loadViewIfNeeded() }
    return ColorPickerInteractor(
      initialState: .init(),
      presenter: viewController
    )
  }
  
}
