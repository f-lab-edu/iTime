//
//  AppRootRouter.swift
//  iTime
//
//  Created by 이상헌 on 2023/10/26.
//

import RIBs

import LoggedOut

// MARK: - AppRootInteractable

protocol AppRootInteractable: Interactable, LoggedOutListener {
    var router: AppRootRouting? { get set }
    var listener: AppRootListener? { get set }
}

// MARK: - AppRootViewControllable

protocol AppRootViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

// MARK: - AppRootRouter

final class AppRootRouter:
    LaunchRouter<AppRootInteractable,
    AppRootViewControllable>,
    AppRootRouting
{
    
    private let loggedOutBuilder: LoggedOutBuildable
    private var loggedOutRouter: LoggedOutRouting?
    
    init(
        interactor: AppRootInteractable,
        viewController: AppRootViewControllable,
        loggedOutBuilder: LoggedOutBuildable
    ) {
        self.loggedOutBuilder = loggedOutBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachLoggedOut() {
        guard loggedOutRouter == nil else { return }
        
        let router = loggedOutBuilder.build(
            with: LoggedOutBuildDependency(
                listener: interactor
            )
        )
        loggedOutRouter = router
        attachChild(router)
        viewController.present(router.viewControllable, animated: true, completion: nil)
    }
    
    func detachLoggedOut() {
        guard let router = loggedOutRouter else { return }
        loggedOutRouter = nil
        detachChild(router)
        viewController.popViewController(animated: false, completion: nil)
    }
}
