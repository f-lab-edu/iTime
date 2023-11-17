//
//  LogEntryEditorRouter.swift
//  
//
//  Created by 이상헌 on 11/13/23.
//

import RIBs

import Start

// MARK: - LogEntryEditorInteractable

protocol LogEntryEditorInteractable: Interactable {
  var router: LogEntryEditorRouting? { get set }
  var listener: LogEntryEditorListener? { get set }
}

// MARK: - LogEntryEditorViewControllable

protocol LogEntryEditorViewControllable: ViewControllable {
}

// MARK: - LogEntryEditorRouter

final class LogEntryEditorRouter:
  ViewableRouter<LogEntryEditorInteractable,
  LogEntryEditorViewControllable>,
  LogEntryEditorRouting
{
  
  // MARK: - Properties
  
  // MARK: - Initialization & DeInitialization
  
  override init(
    interactor: LogEntryEditorInteractable,
    viewController: LogEntryEditorViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
}
