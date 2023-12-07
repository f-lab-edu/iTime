//
//  HistoryRouter.swift
//  
//
//  Created by 이상헌 on 12/7/23.
//

import RIBs

import History

// MARK: - HistoryInteractable

protocol HistoryInteractable: Interactable {
  var router: HistoryRouting? { get set }
  var listener: HistoryListener? { get set }
}

// MARK: - HistoryViewControllable

protocol HistoryViewControllable: ViewControllable {
}

// MARK: - HistoryRouter

final class HistoryRouter:
  ViewableRouter<HistoryInteractable,
  HistoryViewControllable>,
  HistoryRouting
{
  
  // MARK: - Properties
  
  // MARK: - Initialization & DeInitialization
  
  override init(
    interactor: HistoryInteractable,
    viewController: HistoryViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
}
