//
//  AppRootBuilder.swift
//  iTime
//
//  Created by 이상헌 on 2023/10/26.
//

import RIBs

import AppRoot
import LoggedOut
import LoggedIn
import Usecase

public protocol AppRootDependency: Dependency {
  var authenticationUsecase: AuthenticationUsecase { get }
  var loggedInBuilder: LoggedInBuildable { get }
  var loggedOutBuilder: LoggedOutBuildable { get }
  var timeLogUsecase: TimeLogUsecase { get }
}

final class AppRootComponent: Component<AppRootDependency>
{
}

// MARK: - Builder

public final class AppRootBuilder:
  Builder<AppRootDependency>,
  AppRootBuildable
{
  public override init(dependency: AppRootDependency) {
    super.init(dependency: dependency)
  }
  
  public func build() -> LaunchRouting {
    let viewController = AppRootViewController()
    let _ = AppRootComponent(dependency: dependency)
    let interactor = AppRootInteractor(
      presenter: viewController, 
      timeLogUsecase: dependency.timeLogUsecase,
      authenticationUsecase: dependency.authenticationUsecase
    )
    
    return AppRootRouter(
      interactor: interactor,
      viewController: viewController,
      loggedOutBuilder: dependency.loggedOutBuilder,
      loggedInBuilder: dependency.loggedInBuilder
    )
  }
}

