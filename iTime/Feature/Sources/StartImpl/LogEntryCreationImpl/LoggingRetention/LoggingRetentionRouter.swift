//
//  LoggingRetentionRouter.swift
//  
//
//  Created by 이상헌 on 12/10/23.
//

import RIBs

import LoggingRetention

// MARK: - LoggingRetentionInteractable

protocol LoggingRetentionInteractable: Interactable {
  var router: LoggingRetentionRouting? { get set }
  var listener: LoggingRetentionListener? { get set }
}

// MARK: - LoggingRetentionViewControllable

protocol LoggingRetentionViewControllable: ViewControllable {
}

// MARK: - LoggingRetentionRouter

final class LoggingRetentionRouter:
  ViewableRouter<LoggingRetentionInteractable,
  LoggingRetentionViewControllable>,
  LoggingRetentionRouting
{
  
  // MARK: - Properties
  
  // MARK: - Initialization & DeInitialization
  
  override init(
    interactor: LoggingRetentionInteractable,
    viewController: LoggingRetentionViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
}
