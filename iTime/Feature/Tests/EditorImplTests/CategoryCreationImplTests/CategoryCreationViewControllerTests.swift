//
//  CategoryCreationViewControllerTest.swift
//  
//
//  Created by 이상헌 on 3/6/24.
//

import XCTest
import SnapshotTesting
@testable import EditorImpl

final class CategoryCreationViewControllerTests: XCTestCase {

  private var sut: CategoryCreationViewController!
  
  override func setUp() {
    super.setUp()
    
    sut = CategoryCreationViewController()
  }
  
  func test_viewDidLoad_addChilds() {
    // Given
    
    // When
    sut.viewDidLoad()
    
    // Then
    
  }
  

}
