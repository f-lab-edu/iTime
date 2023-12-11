//
//  BookmarkListRouter.swift
//
//
//  Created by 이상헌 on 12/10/23.
//

import RIBs

import Start
import Editor

// MARK: - BookmarkListInteractable

protocol BookmarkListInteractable:
  Interactable,
  BookmarkEditorListener
{
  var router: BookmarkListRouting? { get set }
  var listener: BookmarkListListener? { get set }
}

// MARK: - BookmarkListViewControllable

protocol BookmarkListViewControllable: ViewControllable {
}

// MARK: - BookmarkListRouterDependency

protocol BookmarkListRouterDependency {
  var interactor: BookmarkListInteractable { get }
  var viewController: BookmarkListViewControllable & BookmarkListPresentable { get }
  var bookmarkEditorBuilder: BookmarkEditorBuildable { get }
}

// MARK: - BookmarkListRouter

final class BookmarkListRouter:
  ViewableRouter<BookmarkListInteractable,
  BookmarkListViewControllable>,
  BookmarkListRouting
{
  
  // MARK: - Properties
  
  private let bookmarkEditorBuilder: BookmarkEditorBuildable
  private var bookmarkEditorRouter: BookmarkEditorRouting?
  
  // MARK: - Initialization & DeInitialization
  
  init(_ dependency: BookmarkListRouterDependency) {
    self.bookmarkEditorBuilder = dependency.bookmarkEditorBuilder
    super.init(interactor: dependency.interactor, viewController: dependency.viewController)
    dependency.interactor.router = self
  }
  
  // MARK: Route methods
  
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
  
}
