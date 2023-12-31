//
//  LoggedOutBuilder.swift
//  
//
//  Created by 이상헌 on 2023/10/26.
//

import RIBs

import Usecase
import LoggedOut

// MARK: - LoggedOutDependency

public protocol LoggedOutDependency: Dependency {
  var authenticationUsecase: AuthenticationUsecase { get }
}

// MARK: - LoggedOutComponent

public final class LoggedOutComponent: Component<LoggedOutDependency> {
  
}

// MARK: - LoggedOutBuilder

public final class LoggedOutBuilder:
  Builder<LoggedOutDependency>,
  LoggedOutBuildable
{
  public override init(dependency: LoggedOutDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(with listener: LoggedOutListener) -> LoggedOutRouting {
    let componenet = LoggedOutComponent(dependency: dependency)
    let viewController = LoggedOutViewController()
    
    let interactor = LoggedOutInteractor(
      presenter: viewController,
      authenticationUsecase: componenet.dependency.authenticationUsecase
    )
    interactor.listener = listener
    return LoggedOutRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
