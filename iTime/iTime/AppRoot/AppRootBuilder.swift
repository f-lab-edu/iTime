//
//  AppRootBuilder.swift
//  iTime
//
//  Created by 이상헌 on 2023/10/26.
//

import NeedleFoundation
import RIBs

import LoggedOut
import LoggedOutImpl

protocol AppRootDependency: NeedleFoundation.Dependency {
   
}

final class AppRootComponent: NeedleFoundation.Component<AppRootDependency> {
    var loggedOutBuilder: LoggedOutBuildable {
        LoggedOutBuilder {
            LoggedOutComponent(parent: self)
        }
    }
}

// MARK: - Builder

protocol AppRootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class AppRootBuilder:
    SimpleComponentizedBuilder<AppRootComponent, LaunchRouting>,
    AppRootBuildable
{

    override func build(with component: AppRootComponent) -> LaunchRouting {
        let viewController = AppRootViewController()
        let interactor = AppRootInteractor(presenter: viewController)
        
        return AppRootRouter(
            interactor: interactor,
            viewController: viewController,
            loggedOutBuilder: component.loggedOutBuilder
            )
    }
}

