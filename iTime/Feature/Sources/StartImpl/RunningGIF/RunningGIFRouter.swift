//
//  RunningGIFRouter.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs

import Start

// MARK: - RunningGIFInteractable

protocol RunningGIFInteractable: Interactable {
  var router: RunningGIFRouting? { get set }
  var listener: RunningGIFListener? { get set }
}

// MARK: - RunningGIFViewControllable

protocol RunningGIFViewControllable: ViewControllable {
}

// MARK: - RunningGIFRouter

final class RunningGIFRouter:
  ViewableRouter<RunningGIFInteractable,
  RunningGIFViewControllable>,
  RunningGIFRouting
{
  
  // MARK: - Properties
  
  // MARK: - Initialization & DeInitialization
  
  override init(
    interactor: RunningGIFInteractable,
    viewController: RunningGIFViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
}
