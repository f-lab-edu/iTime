//
//  CategoryEditorRouter.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import RIBs

import Start

// MARK: - CategoryEditorInteractable

protocol CategoryEditorInteractable: Interactable {
  var router: CategoryEditorRouting? { get set }
  var listener: CategoryEditorListener? { get set }
}

// MARK: - CategoryEditorViewControllable

protocol CategoryEditorViewControllable: ViewControllable {
}

// MARK: - CategoryEditorRouter

final class CategoryEditorRouter:
  ViewableRouter<CategoryEditorInteractable,
  CategoryEditorViewControllable>,
  CategoryEditorRouting
{
  
  // MARK: - Properties
  
  // MARK: - Initialization & DeInitialization
  
  override init(
    interactor: CategoryEditorInteractable,
    viewController: CategoryEditorViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
}
