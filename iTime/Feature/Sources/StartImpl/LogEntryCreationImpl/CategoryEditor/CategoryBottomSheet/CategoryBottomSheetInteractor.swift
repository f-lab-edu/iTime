//
//  CategoryBottomSheetInteractor.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import RIBs
import RxSwift

import Start

// MARK: - CategoryBottomSheetPresentable

protocol CategoryBottomSheetPresentable: Presentable {
  var listener: CategoryBottomSheetPresentableListener? { get set }
}

// MARK: - CategoryBottomSheetInteractor

final class CategoryBottomSheetInteractor: 
  PresentableInteractor<CategoryBottomSheetPresentable>,
  CategoryBottomSheetInteractable,
  CategoryBottomSheetPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: CategoryBottomSheetRouting?
  weak var listener: CategoryBottomSheetListener?
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: CategoryBottomSheetPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
}
