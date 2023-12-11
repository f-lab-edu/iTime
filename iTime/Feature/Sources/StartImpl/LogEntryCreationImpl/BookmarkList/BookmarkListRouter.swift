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
  
  init(
    interactor: BookmarkListInteractable,
    viewController: BookmarkListViewControllable,
    bookmarkEditorBuilder: BookmarkEditorBuildable
  ) {
    self.bookmarkEditorBuilder = bookmarkEditorBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
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
