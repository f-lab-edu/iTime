//
//  BookmarkEditorRouter.swift
//  
//
//  Created by 이상헌 on 11/14/23.
//

import RIBs

import Start
import Editor

// MARK: - BookmarkEditorInteractable

protocol BookmarkEditorInteractable:
  Interactable,
  BookmarkListListener,
  ActivityHistoryListener
{
  var router: BookmarkEditorRouting? { get set }
  var listener: BookmarkEditorListener? { get set }
}

// MARK: - BookmarkEditorViewControllable

protocol BookmarkEditorViewControllable: ViewControllable {
  func addBookmarkList(_ view: ViewControllable)
  func addActivityHistory(_ view: ViewControllable)
}

// MARK: - BookmarkEditorRouter

final class BookmarkEditorRouter:
  ViewableRouter<BookmarkEditorInteractable,
  BookmarkEditorViewControllable>,
  BookmarkEditorRouting
{
  
  
  // MARK: - Properties
  
  private let bookmarkListBuilder: BookmarkListBuildable
  private var bookmarkListRouter: BookmarkListRouting?
  
  private let activityHistoryBuilder: ActivityHistoryBuildable
  private var activityHistoryRouter: ActivityHistoryRouting?
  
  // MARK: - Initialization & DeInitialization
  
  init(
    interactor: BookmarkEditorInteractable,
    viewController: BookmarkEditorViewControllable,
    bookmarkListBuilder: BookmarkListBuildable,
    activityHistoryBuilder: ActivityHistoryBuildable
  ) {
    self.bookmarkListBuilder = bookmarkListBuilder
    self.activityHistoryBuilder = activityHistoryBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  override func didLoad() {
    super.didLoad()
    attachBookmarkListRIB()
   
  }
  
  // MARK: Route methods
  
  func attachBookmarkListRIB() {
    guard bookmarkListRouter == nil else { return }
    let router = bookmarkListBuilder.build(withListener: interactor)
    bookmarkListRouter = router
    attachChild(router)
    viewController.addBookmarkList(router.viewControllable)
  }
  
  func detachBookmarkListRIB() {
    guard let router = bookmarkListRouter else { return }
    bookmarkListRouter = nil
    detachChild(router)
  }
  
  func attachActivityHistoryRIB() {
    guard activityHistoryRouter == nil else { return }
    let router = activityHistoryBuilder.build(withListener: interactor)
    activityHistoryRouter = router
    attachChild(router)
    viewController.addActivityHistory(router.viewControllable)
  }
  
  func detachActivityHistoryRIB() {
    guard let router = activityHistoryRouter else { return }
    activityHistoryRouter = nil
    detachChild(router)
  }
  
}
