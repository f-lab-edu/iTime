//
//  LogEntryCreationRouter.swift
//
//
//  Created by 이상헌 on 2023/11/05.
//

import RIBs

import Start

// MARK: - LogEntryCreationInteractable

protocol LogEntryCreationInteractable:
  Interactable,
  LogEntryEditorListener,
  BookmarkEditorListener,
  TimeLogRunningListener
{
  var router: LogEntryCreationRouting? { get set }
  var listener: LogEntryCreationListener? { get set }
}

// MARK: - LogEntryCreationViewControllable

protocol LogEntryCreationViewControllable: ViewControllable {
}

// MARK: - LogEntryCreationRouter

final class LogEntryCreationRouter:
  ViewableRouter<LogEntryCreationInteractable,
  LogEntryCreationViewControllable>,
  LogEntryCreationRouting
{
  
  private let logEntryEditorBuilder: LogEntryEditorBuildable
  private var logEntryEditorRouter: LogEntryEditorRouting?
  
  private let bookmarkEditorBuilder: BookmarkEditorBuildable
  private var bookmarkEditorRouter: BookmarkEditorRouting?
  
  private let timeLogRunningBuilder: TimeLogRunningBuildable
  private var timeLogRunningRouter: TimeLogRunningRouting?
  
  init(
    interactor: LogEntryCreationInteractable,
    viewController: LogEntryCreationViewControllable,
    logEntryEditorBuilder: LogEntryEditorBuildable,
    bookmarkEditorBuilder: BookmarkEditorBuildable,
    timeLogRunningBuilder: TimeLogRunningBuildable
  ) {
    self.logEntryEditorBuilder = logEntryEditorBuilder
    self.bookmarkEditorBuilder = bookmarkEditorBuilder
    self.timeLogRunningBuilder = timeLogRunningBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  func attachLogEntryEditorRIB() {
    guard logEntryEditorRouter == nil else { return }
    let router = logEntryEditorBuilder.build(withListener: interactor)
    logEntryEditorRouter = router
    attachChild(router)
    viewController.presentFullScreen(
      router.viewControllable,
      animated: true,
      completion: nil
    )
  }
  
  func detachLogEntryEditorRIB() {
    guard let router = logEntryEditorRouter else { return }
    logEntryEditorRouter = nil
    detachChild(router)
    viewController.dismiss(animated: true, completion: nil)
  }
  
  func attachBookmarkEditorRIB() {
    guard bookmarkEditorRouter == nil else { return }
    let router = bookmarkEditorBuilder.build(withListener: interactor)
    bookmarkEditorRouter = router
    attachChild(router)
    viewController.presentFullScreen(
      router.viewControllable,
      animated: true,
      completion: nil
    )
  }
  
  func detachBookmarkEditorRIB() {
    guard let router = bookmarkEditorRouter else { return }
    bookmarkEditorRouter = nil
    detachChild(router)
    viewController.dismiss(animated: true, completion: nil)
  }
  
  func attachTimeLogRunningRIB() {
    guard timeLogRunningRouter == nil else { return }
    let router = timeLogRunningBuilder.build(withListener: interactor)
    timeLogRunningRouter = router
    attachChild(router)
    router.viewControllable.uiviewController.hidesBottomBarWhenPushed = true
    viewController.pushViewController(router.viewControllable, animated: true)
  }
  
  func detachTimeLogRunningRIB() {
    guard let router = timeLogRunningRouter else { return }
    timeLogRunningRouter = nil
    detachChild(router)
    viewController.popViewController(animated: true, completion: nil)
  }
}
