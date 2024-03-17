//
//  CategoryListRouter.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs

import Editor

// MARK: - CategoryListInteractable

protocol CategoryListInteractable: 
  Interactable
{
  var router: CategoryListRouting? { get set }
  var listener: CategoryListListener? { get set }
}

// MARK: - CategoryListViewControllable

protocol CategoryListViewControllable: ViewControllable {
}

// MARK: - CategoryListRouter

final class CategoryListRouter:
  ViewableRouter<CategoryListInteractable,
  CategoryListViewControllable>,
  CategoryListRouting
{
  
  // MARK: - Properties
  
  // MARK: - Initialization & DeInitialization
  
  override init(
    interactor: CategoryListInteractable,
    viewController: CategoryListViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
}
