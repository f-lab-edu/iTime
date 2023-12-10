//
//  ActivityHistoryInteractor.swift
//  
//
//  Created by 이상헌 on 12/10/23.
//

import RIBs
import RxSwift

import Editor

// MARK: - ActivityHistoryPresentable

protocol ActivityHistoryPresentable: Presentable {
  var listener: ActivityHistoryPresentableListener? { get set }
}

// MARK: - ActivityHistoryInteractor

final class ActivityHistoryInteractor: 
  PresentableInteractor<ActivityHistoryPresentable>,
  ActivityHistoryInteractable,
  ActivityHistoryPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: ActivityHistoryRouting?
  weak var listener: ActivityHistoryListener?
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: ActivityHistoryPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
  
  func didTapTagCell() {
    
  }
  
  func numberOfItems() -> Int {
    1
  }
  
  func bookmark(at index: Int) -> String {
    "22"
  }
}
