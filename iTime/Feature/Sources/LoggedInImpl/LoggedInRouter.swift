//
//  LoggedInRouter.swift
//  
//
//  Created by 이상헌 on 2023/11/02.
//

import RIBs

import Start
import LoggedIn

protocol LoggedInInteractable:
  Interactable,
  StartListener
{
  var router: LoggedInRouting? { get set }
  var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
  func setViewControllers(_ viewControllers: [ViewControllable], animated: Bool)
}

final class LoggedInRouter:
  ViewableRouter<LoggedInInteractable, LoggedInViewControllable>,
  LoggedInRouting
{
  private let startBuilder: StartBuildable
  private var startRouter: StartRouting?
  
  init(
    interactor: LoggedInInteractable,
    viewController: LoggedInViewControllable,
    startBuilder: StartBuildable
  ) {
    self.startBuilder = startBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  func attachTabs() {
    let tabs: [ViewControllable] = [
      attachStartRIB()
    ]
    
    viewController.setViewControllers(tabs, animated: false)
  }
  
  private func attachStartRIB() -> ViewControllable {
    let router = startBuilder.build(
      withListener: interactor
    )
    startRouter = router
    attachChild(router)
    return router.viewControllable
  }
  
}
