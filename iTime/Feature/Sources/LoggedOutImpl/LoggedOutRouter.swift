//
//  LoggedOutRouter.swift
//  
//
//  Created by 이상헌 on 2023/10/26.
//

import RIBs

import LoggedOut

// MARK: - LoggedOutInteractable

protocol LoggedOutInteractable: Interactable {
    var router: LoggedOutRouting? { get set }
    var listener: LoggedOutListener? { get set }
}

protocol LoggedOutViewControllable: ViewControllable {}

// MARK: - LoggedOutRouter

final class LoggedOutRouter:
  ViewableRouter<LoggedOutInteractable, LoggedOutViewControllable>,
  LoggedOutRouting
{

    override init(
      interactor: LoggedOutInteractable,
      viewController: LoggedOutViewControllable
    ) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
