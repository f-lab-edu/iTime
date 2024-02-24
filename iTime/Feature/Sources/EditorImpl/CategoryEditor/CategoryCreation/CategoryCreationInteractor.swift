//
//  CategoryCreationInteractor.swift
//  
//
//  Created by 이상헌 on 12/7/23.
//

import RIBs
import RxSwift
import RxRelay

import Editor

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
  private let state: BehaviorRelay<CategoryCreationState>
  
  // MARK: - Initialization & DeInitialization
  
  init(
    initialState: BehaviorRelay<CategoryCreationState>,
    presenter: CategoryCreationPresentable
  ) {
    self.state = initialState
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
}
