//
//  CurrentActivityRouter.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs

import Start

// MARK: - CurrentActivityInteractable

public protocol CurrentActivityInteractable: Interactable {
  var router: CurrentActivityRouting? { get set }
  var listener: CurrentActivityListener? { get set }
}

// MARK: - CurrentActivityViewControllable

public protocol CurrentActivityViewControllable: ViewControllable {
}

// MARK: - CurrentActivityRouter

final class CurrentActivityRouter:
  ViewableRouter<CurrentActivityInteractable,
  CurrentActivityViewControllable>,
  CurrentActivityRouting
{
  
  // MARK: - Properties
  
  // MARK: - Initialization & DeInitialization
  
  override init(
    interactor: CurrentActivityInteractable,
    viewController: CurrentActivityViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
}
