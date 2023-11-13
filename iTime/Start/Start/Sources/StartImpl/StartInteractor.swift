//
//  StartInteractor.swift
//  
//
//  Created by 이상헌 on 11/11/23.
//

import RIBs
import RxSwift

import Start

// MARK: - StartPresentable

protocol StartPresentable: Presentable {
  var listener: StartPresentableListener? { get set }
}

// MARK: - StartInteractor

final class StartInteractor: 
  PresentableInteractor<StartPresentable>,
  StartInteractable,
  StartPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: StartRouting?
  weak var listener: StartListener?
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: StartPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
    router?.attachLogEntryCreationRIB()
  }
}
