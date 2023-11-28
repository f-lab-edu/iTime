//
//  CategoryEditorInteractor.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import RIBs
import RxSwift

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
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: CategoryEditorPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
}
