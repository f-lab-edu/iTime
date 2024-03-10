//
//  CategoryEditorInteractor.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import RIBs
import RxSwift

import Entities
import Usecase
import Editor


// MARK: - CategoryEditorPresentable

protocol CategoryEditorPresentable: Presentable {
  var listener: CategoryEditorPresentableListener? { get set }
}

// MARK: - CategoryEditorInteractor

final class CategoryEditorInteractor: 
  PresentableInteractor<CategoryEditorPresentable>,
  CategoryEditorInteractable,
  CategoryEditorPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: CategoryEditorRouting?
  weak var listener: CategoryEditorListener?
  
  private let timerUsecase: TimerUsecase
  private(set) var state: CategoryEditorState
  
  // MARK: - Initialization & DeInitialization
  
  init(
    initialState: CategoryEditorState,
    timerUsecase: TimerUsecase,
    presenter: CategoryEditorPresentable
  ) {
    self.state = initialState
    self.timerUsecase = timerUsecase
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
    suspendTimer()
  }
  
  func didTapCategoryListCell(from category: Category) {
    router?.attachCategoryModificationRIB(with: category)
  }
  
  func didTriggerDisappearAction() {
    listener?.detachCategoryEditorRIB()
  }
  
  private func suspendTimer() {
    timerUsecase.suspend()
  }
  
  func didTapCategoryCreationLabel() {
    router?.attachCategoryCreationRIB()
  }
}

// MARK: - listener

extension CategoryEditorInteractor {
  func detachCategoryCreationRIB() {
    router?.detachCategoryCreationRIB()
  }
  
  func detachCategoryModificationRIB() {
    router?.detachCategoryModificationRIB()
  }
}
