//
//  TimerOperationInteractor.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs
import RxSwift

import Start

// MARK: - TimerOperationPresentable

protocol TimerOperationPresentable: Presentable {
  var listener: TimerOperationPresentableListener? { get set }
}

// MARK: - TimerOperationInteractor

final class TimerOperationInteractor: 
  PresentableInteractor<TimerOperationPresentable>,
  TimerOperationInteractable,
  TimerOperationPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: TimerOperationRouting?
  weak var listener: TimerOperationListener?
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: TimerOperationPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
}
