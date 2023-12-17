//
//  CurrentTimerTimeInteractor.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs
import RxSwift

import Start

// MARK: - CurrentTimerTimePresentable

protocol CurrentTimerTimePresentable: Presentable {
  var listener: CurrentTimerTimePresentableListener? { get set }
}

// MARK: - CurrentTimerTimeInteractor

final class CurrentTimerTimeInteractor: 
  PresentableInteractor<CurrentTimerTimePresentable>,
  CurrentTimerTimeInteractable,
  CurrentTimerTimePresentableListener
{
  
  // MARK: - Properties
  
  weak var router: CurrentTimerTimeRouting?
  weak var listener: CurrentTimerTimeListener?
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: CurrentTimerTimePresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
}
