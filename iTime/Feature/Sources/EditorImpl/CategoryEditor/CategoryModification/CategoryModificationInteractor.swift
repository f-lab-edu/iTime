//
//  CategoryModificationInteractor.swift
//  
//
//  Created by 이상헌 on 3/10/24.
//

import RIBs
import RxSwift

import Editor

// MARK: - CategoryModificationPresentable

protocol CategoryModificationPresentable: Presentable {
  var listener: CategoryModificationPresentableListener? { get set }
  func updateCategoryTitle(with title: String)
  func updateCategoryColorHex(with hex: String)
}

// MARK: - CategoryModificationInteractor

final class CategoryModificationInteractor: 
  PresentableInteractor<CategoryModificationPresentable>,
  CategoryModificationInteractable,
  CategoryModificationPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: CategoryModificationRouting?
  weak var listener: CategoryModificationListener?
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: CategoryModificationPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
  
  func currentCategoryTitle(with title: String) {
    presenter.updateCategoryTitle(with: title)
  }
  
  func currentCategoryColorHex(with hex: String) {
    presenter.updateCategoryColorHex(with: hex)
  }
  
  func didTriggerDissapearAction() {
    listener?.detachCategoryModificationRIB()
  }
}
