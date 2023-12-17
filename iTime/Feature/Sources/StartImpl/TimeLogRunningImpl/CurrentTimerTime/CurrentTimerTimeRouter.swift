//
//  CurrentTimerTimeRouter.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs

import Start

// MARK: - CurrentTimerTimeInteractable

protocol CurrentTimerTimeInteractable: Interactable {
  var router: CurrentTimerTimeRouting? { get set }
  var listener: CurrentTimerTimeListener? { get set }
}

// MARK: - CurrentTimerTimeViewControllable

protocol CurrentTimerTimeViewControllable: ViewControllable {
}

// MARK: - CurrentTimerTimeRouter

final class CurrentTimerTimeRouter:
  ViewableRouter<CurrentTimerTimeInteractable,
  CurrentTimerTimeViewControllable>,
  CurrentTimerTimeRouting
{
  
  // MARK: - Properties
  
  // MARK: - Initialization & DeInitialization
  
  override init(
    interactor: CurrentTimerTimeInteractable,
    viewController: CurrentTimerTimeViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
}
