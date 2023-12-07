//
//  CategoryCreationInteractor.swift
//  
//
//  Created by 이상헌 on 12/7/23.
//

import RIBs
import RxSwift

import CategoryCreation

// MARK: - CategoryCreationPresentable

protocol CategoryCreationPresentable: Presentable {
  var listener: CategoryCreationPresentableListener? { get set }
}

// MARK: - CategoryCreationInteractor

final class CategoryCreationInteractor: 
  PresentableInteractor<CategoryCreationPresentable>,
  CategoryCreationInteractable,
  CategoryCreationPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: CategoryCreationRouting?
  weak var listener: CategoryCreationListener?
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: CategoryCreationPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
}
