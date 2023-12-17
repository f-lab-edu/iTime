//
//  CurrentActivityInteractor.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs
import RxSwift

import Start

// MARK: - CurrentActivityPresentable

protocol CurrentActivityPresentable: Presentable {
  var listener: CurrentActivityPresentableListener? { get set }
}

// MARK: - CurrentActivityInteractor

final class CurrentActivityInteractor: 
  PresentableInteractor<CurrentActivityPresentable>,
  CurrentActivityInteractable,
  CurrentActivityPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: CurrentActivityRouting?
  weak var listener: CurrentActivityListener?
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: CurrentActivityPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
}
