//
//  HistoryInteractor.swift
//  
//
//  Created by 이상헌 on 12/7/23.
//

import RIBs
import RxSwift

import History

// MARK: - HistoryPresentable

protocol HistoryPresentable: Presentable {
  var listener: HistoryPresentableListener? { get set }
}

// MARK: - HistoryInteractor

final class HistoryInteractor: 
  PresentableInteractor<HistoryPresentable>,
  HistoryInteractable,
  HistoryPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: HistoryRouting?
  weak var listener: HistoryListener?
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: HistoryPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
}
