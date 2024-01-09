//
//  LogEntryCreationRouter.swift
//
//
//  Created by 이상헌 on 2023/11/05.
//

import RIBs

import Start
import Editor
import SharedUI

// MARK: - LogEntryCreationInteractable

protocol LogEntryCreationInteractable:
  Interactable,
  LogEntryEditorListener,
  BookmarkListListener,
  LoggingRetentionListener,
  TimeLogRunningListener,
  BookmarkEditorListener
{
  var router: LogEntryCreationRouting? { get set }
  var listener: LogEntryCreationListener? { get set }
}

// MARK: - LogEntryCreationViewControllable

protocol LogEntryCreationViewControllable: ViewControllable {
  func addBookmarkList(_ view: ViewControllable)
  func addLoggingRetention(_ view: ViewControllable)
}

// MARK: - LogEntryCreationRouter

final class LogEntryCreationRouter:
  ViewableRouter<LogEntryCreationInteractable,
  LogEntryCreationViewControllable>,
  LogEntryCreationRouting
{
  
  // MARK: - Properties
  
  private let logEntryEditorBuilder: LogEntryEditorBuildable
  private var logEntryEditorRouter: LogEntryEditorRouting?
  
  private let timeLogRunningBuilder: TimeLogRunningBuildable
  private var timeLogRunningRouter: TimeLogRunningRouting?
  
  private let bookmarkListBuilder: BookmarkListBuildable
  private var bookmarkListRouter: BookmarkListRouting?
  
  private let loggingRetentionBuilder: LoggingRetentionBuildable
  private var loggingRetentionRouter: LoggingRetentionRouting?
  
  private let bookmarkEditorBuilder: BookmarkEditorBuildable
  private var bookmarkEditorRouter: BookmarkEditorRouting?

  // MARK: - Initialization
  
  init(
    interactor: LogEntryCreationInteractable,
    viewController: LogEntryCreationViewControllable,
    logEntryEditorBuilder: LogEntryEditorBuildable,
    timeLogRunningBuilder: TimeLogRunningBuildable,
    bookmarkListBuilder: BookmarkListBuildable,
    loggingRetentionBuilder: LoggingRetentionBuildable,
    bookmarkEditorBuilder: BookmarkEditorBuildable
  ) {
    self.logEntryEditorBuilder = logEntryEditorBuilder
    self.timeLogRunningBuilder = timeLogRunningBuilder
    self.bookmarkListBuilder = bookmarkListBuilder
    self.loggingRetentionBuilder = loggingRetentionBuilder
    self.bookmarkEditorBuilder = bookmarkEditorBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  override func didLoad() {
    super.didLoad()
    attachBookmarkListRIB()
    attachLoggingRetentionRIB()
  }
  
  // MARK: Route methods
  
  func attachBookmarkListRIB() {
    guard bookmarkListRouter == nil else { return }
    let router = bookmarkListBuilder.build(
      withListener: interactor,
      payload: BookmarkListBuildDependency(
        alignedCollectionViewFlowLayout: CenterAlignedCollectionViewFlowLayout(),
        borderColor: .init(innerColor: .black60),
        emptyLabel: "즐겨찾기를 등록해\n빠른 활동 시작을 해보세요!",
        emptyTextAlignment: .center
      )
    )
    bookmarkListRouter = router
    attachChild(router)
    viewController.addBookmarkList(router.viewControllable)
  }
  
  func detachBookmarkListRIB() {
    guard let router = bookmarkListRouter else { return }
    bookmarkListRouter = nil
    detachChild(router)
  }
  
  func attachLoggingRetentionRIB() {
    guard loggingRetentionRouter == nil else { return }
    let router = loggingRetentionBuilder.build(withListener: interactor)
    loggingRetentionRouter = router
    attachChild(router)
    viewController.addLoggingRetention(router.viewControllable)
  }
  
  func detachLoggingRetentionRIB() {
    guard let router = loggingRetentionRouter else { return }
    loggingRetentionRouter = nil
    detachChild(router)
  }
  
  func attachLogEntryEditorRIB() {
    guard logEntryEditorRouter == nil else { return }
    let router = logEntryEditorBuilder.build(withListener: interactor)
    logEntryEditorRouter = router
    attachChild(router)
    let navigationControllerable = NavigationControllerable(root: router.viewControllable)
    viewController.presentFullScreen(
      navigationControllerable,
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
  
  func attachTimeLogRunningRIB() {
    guard timeLogRunningRouter == nil else { return }
    let router = timeLogRunningBuilder.build(
      withListener: interactor
    )
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
  
  func attachBookmarkEditorRIB() {
    guard bookmarkEditorRouter == nil else { return }
    let router = bookmarkEditorBuilder.build(withListener: interactor)
    bookmarkEditorRouter = router
    attachChild(router)
    viewController.pushViewController(router.viewControllable, animated: true)
  }
  
  func detachBookmarkEditorRIB() {
    guard let router = bookmarkEditorRouter else { return }
    bookmarkEditorRouter = nil
    detachChild(router)
    viewController.popViewController(animated: true, completion: nil)
  }
}
