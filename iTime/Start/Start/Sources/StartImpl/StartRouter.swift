//
//  StartRouter.swift
//
//
//  Created by 이상헌 on 11/11/23.
//

import RIBs

import Start

// MARK: - StartInteractable

protocol StartInteractable:
  Interactable,
  LogEntryCreationListener
{
  var router: StartRouting? { get set }
  var listener: StartListener? { get set }
}

// MARK: - StartViewControllable

protocol StartViewControllable: ViewControllable {
  func addChildView(_ view: ViewControllable)
  func removeChild(_ view: ViewControllable)
}

// MARK: - StartRouter

final class StartRouter:
  ViewableRouter<StartInteractable,
  StartViewControllable>,
  StartRouting
{
  
  // MARK: - Properties
  
  private let logEntryCreationBuilder: LogEntryCreationBuildable
  private var logEntryCreationRouter: LogEntryCreationRouting?
  
  // MARK: - Initialization & DeInitialization
  
  init(
    interactor: StartInteractable,
    viewController: StartViewControllable,
    logEntryCreationBuilder: LogEntryCreationBuildable
  ) {
    self.logEntryCreationBuilder = logEntryCreationBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
  func attachLogEntryCreationRIB() {
    guard logEntryCreationRouter == nil else { return }
    let router = logEntryCreationBuilder.build(withListener: interactor)
    attachChild(router)
    logEntryCreationRouter = router
    viewController.addChildView(router.viewControllable)
  }
  
  func detachLogEntryCreationRIB() {
    guard let router = logEntryCreationRouter else { return }
    logEntryCreationRouter = nil
    detachChild(router)
    viewController.removeChild(router.viewControllable)
  }
}
