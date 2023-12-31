//
//  CategoryListInteractor.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs
import RxSwift

import Editor

// MARK: - CategoryListPresentable

protocol CategoryListPresentable: Presentable {
  var listener: CategoryListPresentableListener? { get set }
}

// MARK: - CategoryListInteractor

final class CategoryListInteractor: 
  PresentableInteractor<CategoryListPresentable>,
  CategoryListInteractable,
  CategoryListPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: CategoryListRouting?
  weak var listener: CategoryListListener?
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: CategoryListPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
}
