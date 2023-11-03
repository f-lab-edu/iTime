//
//  StartBuilder.swift
//  
//
//  Created by 이상헌 on 2023/11/03.
//

import RIBs

protocol StartDependency: Dependency {
    var StartViewController: StartViewControllable { get }
}

final class StartComponent: Component<StartDependency> {

    fileprivate var StartViewController: StartViewControllable {
        return dependency.StartViewController
    }
}

// MARK: - Builder

protocol StartBuildable: Buildable {
    func build(withListener listener: StartListener) -> StartRouting
}

final class StartBuilder: Builder<StartDependency>, StartBuildable {

    override init(dependency: StartDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: StartListener) -> StartRouting {
        let component = StartComponent(dependency: dependency)
        let interactor = StartInteractor()
        interactor.listener = listener
        return StartRouter(interactor: interactor, viewController: component.StartViewController)
    }
}
