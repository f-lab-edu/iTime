//
//  RunningGIFInteractor.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs
import RxSwift

import Start

// MARK: - RunningGIFPresentable

protocol RunningGIFPresentable: Presentable {
  var listener: RunningGIFPresentableListener? { get set }
}

// MARK: - RunningGIFInteractor

final class RunningGIFInteractor: 
  PresentableInteractor<RunningGIFPresentable>,
  RunningGIFInteractable,
  RunningGIFPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: RunningGIFRouting?
  weak var listener: RunningGIFListener?
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: RunningGIFPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
}
