//
//  LogEntryCreationRouter.swift
//
//
//  Created by 이상헌 on 2023/11/05.
//

import RIBs

import Start

protocol LogEntryCreationInteractable: 
  Interactable,
  LogEntryEditorListener
{
  var router: LogEntryCreationRouting? { get set }
  var listener: LogEntryCreationListener? { get set }
}

protocol LogEntryCreationViewControllable: ViewControllable {
}

final class LogEntryCreationRouter:
  ViewableRouter<LogEntryCreationInteractable,
  LogEntryCreationViewControllable>,
  LogEntryCreationRouting
{
  
  private let logEntryEditorBuilder: LogEntryEditorBuildable
  private var logEntryEditorRouter: LogEntryEditorRouting?
  
  init(
    interactor: LogEntryCreationInteractable,
    viewController: LogEntryCreationViewControllable,
    logEntryEditorBuilder: LogEntryEditorBuildable
  ) {
    self.logEntryEditorBuilder = logEntryEditorBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  func attachLogEntryEditorRIB() {
    guard logEntryEditorRouter == nil else { return }
    let router = logEntryEditorBuilder.build(withListener: interactor)
    attachChild(router)
    logEntryEditorRouter = router
    viewController.presentFullScreen(
      router.viewControllable,
      animated: true,
      completion: nil
    )
  }
  
}
