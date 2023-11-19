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
  BookmarkEditorListener
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
  
  init(
    interactor: LogEntryCreationInteractable,
    viewController: LogEntryCreationViewControllable,
    logEntryEditorBuilder: LogEntryEditorBuildable,
    bookmarkEditorBuilder: BookmarkEditorBuildable
  ) {
    self.logEntryEditorBuilder = logEntryEditorBuilder
    self.bookmarkEditorBuilder = bookmarkEditorBuilder
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
  
  func detachLogEntryEditorRIB() {
    guard let router = logEntryEditorRouter else { return }
    detachChild(router)
    logEntryEditorRouter = nil
    viewController.dismiss(animated: true, completion: nil)
  }
  
  func attachBookmarkEditorRIB() {
    guard bookmarkEditorRouter == nil else { return }
    let router = bookmarkEditorBuilder.build(withListener: interactor)
    attachChild(router)
    bookmarkEditorRouter = router
    viewController.presentFullScreen(
      router.viewControllable,
      animated: true,
      completion: nil
    )
  }
  
  func detachBookmarkEditorRIB() {
    guard let router = bookmarkEditorRouter else { return }
    detachChild(router)
    bookmarkEditorRouter = nil
    viewController.dismiss(animated: true, completion: nil)
  }
}
