//
//  HistoryBuilder.swift
//  
//
//  Created by 이상헌 on 12/7/23.
//

import RIBs

import History

// MARK: - HistoryDependency

public protocol HistoryDependency: Dependency {
  
}

// MARK: - HistoryComponent

final class HistoryComponent: Component<HistoryDependency> {
  
}

// MARK: - HistoryBuilder

public final class HistoryBuilder:
  Builder<HistoryDependency>,
  HistoryBuildable
{
  
  public override init(dependency: HistoryDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: HistoryListener) -> HistoryRouting {
    let component = HistoryComponent(dependency: dependency)
    let viewController = HistoryViewController()
    let interactor = HistoryInteractor(presenter: viewController)
    interactor.listener = listener
    return HistoryRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
