//
//  LoggedInBuilder.swift
//  
//
//  Created by 이상헌 on 2023/11/02.
//

import RIBs

import LoggedIn

protocol LoggedInDependency: Dependency {
}

final class LoggedInComponent: Component<LoggedInDependency> {
}

// MARK: - Builder

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {
  
  override init(dependency: LoggedInDependency) {
    super.init(dependency: dependency)
  }
  
  func build(withListener listener: LoggedInListener) -> LoggedInRouting {
    let component = LoggedInComponent(dependency: dependency)
    let viewController = LoggedInViewController()
    let interactor = LoggedInInteractor(presenter: viewController)
    interactor.listener = listener
    return LoggedInRouter(interactor: interactor, viewController: viewController)
  }
}
