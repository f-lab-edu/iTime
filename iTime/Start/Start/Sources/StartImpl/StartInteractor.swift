//
//  StartInteractor.swift
//  
//
//  Created by 이상헌 on 2023/11/03.
//

import RIBs
import RxSwift

import Start

final class StartInteractor:
  Interactor,
  StartInteractable
{
  
  weak var router: StartRouting?
  weak var listener: StartListener?
  
  override init() {}
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
  
  override func willResignActive() {
    super.willResignActive()
    
    router?.cleanupViews()
  }
}