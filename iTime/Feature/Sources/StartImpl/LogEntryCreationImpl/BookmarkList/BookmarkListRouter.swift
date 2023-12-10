//
//  BookmarkListRouter.swift
//  
//
//  Created by 이상헌 on 12/10/23.
//

import RIBs

import BookmarkList

// MARK: - BookmarkListInteractable

protocol BookmarkListInteractable: Interactable {
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
  
  // MARK: - Initialization & DeInitialization
  
  override init(
    interactor: BookmarkListInteractable,
    viewController: BookmarkListViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
}
