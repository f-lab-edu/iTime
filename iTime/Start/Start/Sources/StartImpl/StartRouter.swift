//
//  StartRouter.swift
//  
//
//  Created by 이상헌 on 2023/11/03.
//

import RIBs

import Start

protocol StartInteractable: Interactable {
  var router: StartRouting? { get set }
  var listener: StartListener? { get set }
}

final class StartRouter:
  Router<StartInteractable>,
  StartRouting
{
  
  override init(
    interactor: StartInteractable
  ) {
    super.init(interactor: interactor)
    interactor.router = self
  }
  
  func cleanupViews() {
    
  }
  
}
