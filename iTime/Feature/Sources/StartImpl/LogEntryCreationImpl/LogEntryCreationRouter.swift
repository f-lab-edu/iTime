//
//  LogEntryCreationRouter.swift
//  
//
//  Created by 이상헌 on 2023/11/05.
//

import RIBs

import Start

protocol LogEntryCreationInteractable: Interactable {
    var router: LogEntryCreationRouting? { get set }
    var listener: LogEntryCreationListener? { get set }
}

protocol LogEntryCreationViewControllable: ViewControllable {
}

final class LogEntryCreationRouter:
  ViewableRouter<LogEntryCreationInteractable,
  LogEntryCreationViewControllable>,
  LogEntryCreationRouting
{

    override init(interactor: LogEntryCreationInteractable, viewController: LogEntryCreationViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
