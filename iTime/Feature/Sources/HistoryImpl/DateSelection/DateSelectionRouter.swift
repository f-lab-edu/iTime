//
//  DateSelectionRouter.swift
//  
//
//  Created by 이상헌 on 12/7/23.
//

import RIBs

import DateSelection

// MARK: - DateSelectionInteractable

protocol DateSelectionInteractable: Interactable {
  var router: DateSelectionRouting? { get set }
  var listener: DateSelectionListener? { get set }
}

// MARK: - DateSelectionViewControllable

protocol DateSelectionViewControllable: ViewControllable {
}

// MARK: - DateSelectionRouter

final class DateSelectionRouter:
  ViewableRouter<DateSelectionInteractable,
  DateSelectionViewControllable>,
  DateSelectionRouting
{
  
  // MARK: - Properties
  
  // MARK: - Initialization & DeInitialization
  
  override init(
    interactor: DateSelectionInteractable,
    viewController: DateSelectionViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
}
