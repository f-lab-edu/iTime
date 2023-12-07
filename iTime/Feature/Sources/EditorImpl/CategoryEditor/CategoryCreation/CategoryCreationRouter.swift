//
//  CategoryCreationRouter.swift
//  
//
//  Created by 이상헌 on 12/7/23.
//

import RIBs

import Editor

// MARK: - CategoryCreationInteractable

protocol CategoryCreationInteractable: Interactable {
  var router: CategoryCreationRouting? { get set }
  var listener: CategoryCreationListener? { get set }
}

// MARK: - CategoryCreationViewControllable

protocol CategoryCreationViewControllable: ViewControllable {
}

// MARK: - CategoryCreationRouter

final class CategoryCreationRouter:
  ViewableRouter<CategoryCreationInteractable,
  CategoryCreationViewControllable>,
  CategoryCreationRouting
{
  
  // MARK: - Properties
  
  // MARK: - Initialization & DeInitialization
  
  override init(
    interactor: CategoryCreationInteractable,
    viewController: CategoryCreationViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
}
