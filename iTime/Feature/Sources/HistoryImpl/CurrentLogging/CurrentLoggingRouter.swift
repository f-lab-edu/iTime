//
//  CurrentLoggingRouter.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs

import History

// MARK: - CurrentLoggingInteractable

protocol CurrentLoggingInteractable: Interactable {
  var router: CurrentLoggingRouting? { get set }
  var listener: CurrentLoggingListener? { get set }
}

// MARK: - CurrentLoggingViewControllable

protocol CurrentLoggingViewControllable: ViewControllable {
}

// MARK: - CurrentLoggingRouter

final class CurrentLoggingRouter:
  ViewableRouter<CurrentLoggingInteractable,
  CurrentLoggingViewControllable>,
  CurrentLoggingRouting
{
  
  // MARK: - Properties
  
  // MARK: - Initialization & DeInitialization
  
  override init(
    interactor: CurrentLoggingInteractable,
    viewController: CurrentLoggingViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
}
