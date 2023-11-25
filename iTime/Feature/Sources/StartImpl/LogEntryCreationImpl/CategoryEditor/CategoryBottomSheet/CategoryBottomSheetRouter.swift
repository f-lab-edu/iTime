//
//  CategoryBottomSheetRouter.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import RIBs

import Start

// MARK: - CategoryBottomSheetInteractable

protocol CategoryBottomSheetInteractable: Interactable {
  var router: CategoryBottomSheetRouting? { get set }
  var listener: CategoryBottomSheetListener? { get set }
}

// MARK: - CategoryBottomSheetViewControllable

protocol CategoryBottomSheetViewControllable: ViewControllable {
}

// MARK: - CategoryBottomSheetRouter

final class CategoryBottomSheetRouter:
  ViewableRouter<CategoryBottomSheetInteractable,
  CategoryBottomSheetViewControllable>,
  CategoryBottomSheetRouting
{
  
  // MARK: - Properties
  
  // MARK: - Initialization & DeInitialization
  
  override init(
    interactor: CategoryBottomSheetInteractable,
    viewController: CategoryBottomSheetViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
}
