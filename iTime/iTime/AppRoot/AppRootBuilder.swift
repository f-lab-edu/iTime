//
//  AppRootBuilder.swift
//  iTime
//
//  Created by 이상헌 on 2023/10/26.
//

import RIBs

import LoggedOut
import LoggedOutImpl
import Domain
import DomainImpl
import PlatformImpl

protocol AppRootDependency: Dependency {
    
}

final class AppRootComponent:
    Component<AppRootDependency>,
    LoggedOutDependency
{
    var authenticationUsecase: AuthenticationUsecase {
        shared {
            AuthenticationUsecaseImpl(
                appleAuthenticationRepository: FirebaseAppleAuthenticationRepositoryImpl()
            )
        }
    }
}

// MARK: - Builder

protocol AppRootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class AppRootBuilder:
    Builder<AppRootDependency>,
    AppRootBuildable
{
    override init(dependency: AppRootDependency) {
        super.init(dependency: dependency)
    }
    
    func build() -> LaunchRouting {
        let viewController = AppRootViewController()
        let interactor = AppRootInteractor(presenter: viewController)
        let component = AppRootComponent(dependency: dependency)
        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
        
        return AppRootRouter(
            interactor: interactor,
            viewController: viewController,
            loggedOutBuilder: loggedOutBuilder
        )
    }
}

