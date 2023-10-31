//
//  LoggedOutBuilder.swift
//  
//
//  Created by 이상헌 on 2023/10/26.
//

import NeedleFoundation
import RIBs

import Domain
import LoggedOut

// MARK: - LoggedOutDependency

public protocol LoggedOutDependency: NeedleFoundation.Dependency {
    var authenticationUsecase: AuthenticationUsecase { get }
}

// MARK: - LoggedOutComponent

public final class LoggedOutComponent: NeedleFoundation.Component<LoggedOutDependency> {
    fileprivate var initialState: LoggedOutPresentableState {
        LoggedOutPresentableState()
    }
}

// MARK: - LoggedOutBuilder

public final class LoggedOutBuilder:
    ComponentizedBuilder<LoggedOutComponent, LoggedOutRouting, LoggedOutBuildDependency, Void>,
    LoggedOutBuildable
{

    public override func build(
      with component: LoggedOutComponent,
      _ payload: LoggedOutBuildDependency
    ) -> LoggedOutRouting {
        let viewController = LoggedOutViewController()
        let interactor = LoggedOutInteractor(
            presenter: viewController,
            initialState: component.initialState,
            authenticationUsecase: component.authenticationUsecase
        )
        
        interactor.listener = payload.listener
        return LoggedOutRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
