//
//  CurrentLoggingInteractor.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs
import RxSwift

import CurrentLogging

// MARK: - CurrentLoggingPresentable

protocol CurrentLoggingPresentable: Presentable {
  var listener: CurrentLoggingPresentableListener? { get set }
}

// MARK: - CurrentLoggingInteractor

final class CurrentLoggingInteractor: 
  PresentableInteractor<CurrentLoggingPresentable>,
  CurrentLoggingInteractable,
  CurrentLoggingPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: CurrentLoggingRouting?
  weak var listener: CurrentLoggingListener?
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: CurrentLoggingPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
}
