//
//  CategoryEditorInteractorImplTests.swift
//  
//
//  Created by 이상헌 on 2/24/24.
//

import XCTest
import UsecaseTestSupports
import RepositoryTestSupports
import FeatureTestSupports
import Entities
import Editor
@testable import EditorImpl

final class CategoryEditorInteractorImplTests: XCTestCase {
  
  private var sut: CategoryEditorInteractor!
  private var timerUsecase: TimerUsecaseMock!
  private var viewController: CategoryEditorViewController!
  private var router: CategoryEditorRouter!
  private var listener: CategoryEditorListenerSpy!
  
  private let dummyCategory: Entities.Category = .init(title: "dummy category", color: "color")

  override func setUp() {
    timerUsecase = TimerUsecaseMock()
    viewController = CategoryEditorViewController()
    sut = CategoryEditorInteractor(
      initialState: .init(category: dummyCategory),
      timerUsecase: timerUsecase,
      presenter: viewController
    )
    router = CategoryEditorRouter(
      interactor: sut,
      viewController: viewController,
      currentActivityBuilder: CurrentActivityBuilderSpy(),
      categoryListBuilder: CategoryListBuilderSpy(),
      categoryCreationBuilder: CategoryCreationBuilderSpy()
    )
    listener = CategoryEditorListenerSpy()
    sut.router = router
    sut.listener = listener
  }
  
  private func test_didBecomActive했을때_타이머멈춤호출하는지() {
    // When
    sut.activate()
    
    // Then
    XCTAssertEqual(timerUsecase.suspendCallCount, 1)
  }
  
  private func test_didBecomActive했을때_기존카테고리값반영잘하는지() {
    // When
    sut.activate()
    
    // Then
    XCTAssertEqual(sut.state.category, dummyCategory)
  }
  
  private func test_CategoryListListCell탭할시_파라메터포함하여_값_전달이잘되는지() {
    // Given
    let category = Entities.Category(title: "Category", color: "0x22222")
    
    // When
    sut.didTapCategoryListCell(from: category)
    
    // Then
    XCTAssertFalse(router.children.isEmpty)
  }
  
  private func test_backButton탭시_listener에게전달하는지() {
    // When
    sut.didTapBackButton()
    
    // Then
    XCTAssertEqual(listener.detachCategoryEditorRIBCallCount, 1)
  }
  
  private func test_카테고리추가라벨탭시_CategoryCreationRIB호출잘하는지() {
    // When
    sut.didTapCategoryCreationLabel()
    
    // Then
    XCTAssertFalse(router.children.isEmpty)
  }
  
  private func test_바톰시트카테고리편집버튼탭시_CategoryCreationRIB호출잘하는지() {
    // When
    sut.didTapCategoryListCell(from: .empty)
    
    // Then
    XCTAssertFalse(router.children.isEmpty)
  }

}
