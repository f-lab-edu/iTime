//
//  RunningGIFBuilder.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs

import Start

// MARK: - RunningGIFDependency

public protocol RunningGIFDependency: Dependency {
  
}

// MARK: - RunningGIFComponent

final class RunningGIFComponent: Component<RunningGIFDependency> {
  
}

// MARK: - RunningGIFBuilder

public final class RunningGIFBuilder:
  Builder<RunningGIFDependency>,
  RunningGIFBuildable
{
  
  public override init(dependency: RunningGIFDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: RunningGIFListener) -> RunningGIFRouting {
    let component = RunningGIFComponent(dependency: dependency)
    let viewController = RunningGIFViewController()
    let interactor = RunningGIFInteractor(presenter: viewController)
    interactor.listener = listener
    return RunningGIFRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
