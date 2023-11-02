//
//  LoggedInRouter.swift
//  
//
//  Created by 이상헌 on 2023/11/02.
//

import RIBs

import LoggedIn

protocol LoggedInInteractable: Interactable {
  var router: LoggedInRouting? { get set }
  var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
  func setViewControllers(_ viewControllers: [ViewControllable], animated: Bool)
}

final class LoggedInRouter: ViewableRouter<LoggedInInteractable, LoggedInViewControllable>, LoggedInRouting {
  
  override init(
    interactor: LoggedInInteractable,
    viewController: LoggedInViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  func attachTabs() {
    
  }
}
