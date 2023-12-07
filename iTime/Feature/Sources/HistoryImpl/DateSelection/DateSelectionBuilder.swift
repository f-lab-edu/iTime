//
//  DateSelectionBuilder.swift
//  
//
//  Created by 이상헌 on 12/7/23.
//

import RIBs

import DateSelection

// MARK: - DateSelectionDependency

public protocol DateSelectionDependency: Dependency {
  
}

// MARK: - DateSelectionComponent

final class DateSelectionComponent: Component<DateSelectionDependency> {
  
}

// MARK: - DateSelectionBuilder

public final class DateSelectionBuilder:
  Builder<DateSelectionDependency>,
  DateSelectionBuildable
{
  
  public override init(dependency: DateSelectionDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: DateSelectionListener) -> DateSelectionRouting {
    let component = DateSelectionComponent(dependency: dependency)
    let viewController = DateSelectionViewController()
    let interactor = DateSelectionInteractor(presenter: viewController)
    interactor.listener = listener
    return DateSelectionRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
