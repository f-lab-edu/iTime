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

protocol StartViewControllable: ViewControllable {
}

final class StartRouter:
  Router<StartInteractable>,
  StartRouting
{
  
  
  init(
    interactor: StartInteractable,
    viewController: StartViewControllable
  ) {
    self.viewController = viewController
    super.init(interactor: interactor)
    interactor.router = self
  }
  
  func cleanupViews() {
    
  }
  
  // MARK: - Private
  
  private let viewController: StartViewControllable
}
