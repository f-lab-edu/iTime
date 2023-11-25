//
//  BookmarkEditorRouter.swift
//  
//
//  Created by 이상헌 on 11/14/23.
//

import RIBs

import Editor

// MARK: - BookmarkEditorInteractable

protocol BookmarkEditorInteractable: Interactable {
  var router: BookmarkEditorRouting? { get set }
  var listener: BookmarkEditorListener? { get set }
}

// MARK: - BookmarkEditorViewControllable

protocol BookmarkEditorViewControllable: ViewControllable {
}

// MARK: - BookmarkEditorRouter

final class BookmarkEditorRouter:
  ViewableRouter<BookmarkEditorInteractable,
  BookmarkEditorViewControllable>,
  BookmarkEditorRouting
{
  
  // MARK: - Properties
  
  // MARK: - Initialization & DeInitialization
  
  override init(
    interactor: BookmarkEditorInteractable,
    viewController: BookmarkEditorViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
}
