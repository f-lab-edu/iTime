//
//  TimeLogRunningRouter.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import RIBs

import Start

// MARK: - TimeLogRunningInteractable

protocol TimeLogRunningInteractable: Interactable {
  var router: TimeLogRunningRouting? { get set }
  var listener: TimeLogRunningListener? { get set }
}

// MARK: - TimeLogRunningViewControllable

protocol TimeLogRunningViewControllable: ViewControllable {
}

// MARK: - TimeLogRunningRouter

final class TimeLogRunningRouter:
  ViewableRouter<TimeLogRunningInteractable,
  TimeLogRunningViewControllable>,
  TimeLogRunningRouting
{
  
  // MARK: - Properties
  
  // MARK: - Initialization & DeInitialization
  
  override init(
    interactor: TimeLogRunningInteractable,
    viewController: TimeLogRunningViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
}
