//
//  ActivityHistoryRouter.swift
//  
//
//  Created by 이상헌 on 12/10/23.
//

import RIBs

import ActivityHistory

// MARK: - ActivityHistoryInteractable

protocol ActivityHistoryInteractable: Interactable {
  var router: ActivityHistoryRouting? { get set }
  var listener: ActivityHistoryListener? { get set }
}

// MARK: - ActivityHistoryViewControllable

protocol ActivityHistoryViewControllable: ViewControllable {
}

// MARK: - ActivityHistoryRouter

final class ActivityHistoryRouter:
  ViewableRouter<ActivityHistoryInteractable,
  ActivityHistoryViewControllable>,
  ActivityHistoryRouting
{
  
  // MARK: - Properties
  
  // MARK: - Initialization & DeInitialization
  
  override init(
    interactor: ActivityHistoryInteractable,
    viewController: ActivityHistoryViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
}
