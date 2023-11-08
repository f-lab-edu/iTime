//
//  StartBuilder.swift
//  
//
//  Created by 이상헌 on 2023/11/03.
//

import RIBs

import Start

public protocol StartDependency: Dependency {
}

final class StartComponent: Component<StartDependency> {
  
}

public final class StartBuilder:
  Builder<StartDependency>,
  StartBuildable
{  
  public override init(dependency: StartDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: StartListener) -> StartRouting {
    let component = StartComponent(dependency: dependency)
    let interactor = StartInteractor()
    interactor.listener = listener
    return StartRouter(
      interactor: interactor
    )
  }
}
