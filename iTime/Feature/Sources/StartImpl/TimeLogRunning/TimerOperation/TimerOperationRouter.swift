//
//  TimerOperationRouter.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs

import Start

// MARK: - TimerOperationInteractable

protocol TimerOperationInteractable: Interactable {
  var router: TimerOperationRouting? { get set }
  var listener: TimerOperationListener? { get set }
}

// MARK: - TimerOperationViewControllable

protocol TimerOperationViewControllable: ViewControllable {
}

// MARK: - TimerOperationRouter

final class TimerOperationRouter:
  ViewableRouter<TimerOperationInteractable,
  TimerOperationViewControllable>,
  TimerOperationRouting
{
  
  // MARK: - Properties
  
  // MARK: - Initialization & DeInitialization
  
  override init(
    interactor: TimerOperationInteractable,
    viewController: TimerOperationViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
}
