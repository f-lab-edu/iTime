//
//  TextEntryTests.swift
//  
//
//  Created by 이상헌 on 3/6/24.
//

import XCTest
@testable import EditorImpl

final class TextEntryViewControllerTests: XCTestCase {
  
  private var sut: TextEntryViewController!
    
  override func setUp() {
    super.setUp()
    sut = TextEntryViewController()
  }
  
  func test_input_withSingleText_updateCategoryTextField() {
    // Given
    let text = "single"
    
    // When
    sut.updateCategoryTextField(with: text)
    
    // Then
    
    
  }
  
  func test_input_withMultipleText_updateCategoryTextField() {
    
  }
  
}
