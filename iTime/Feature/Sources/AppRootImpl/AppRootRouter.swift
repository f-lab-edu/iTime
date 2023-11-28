//
//  AppRootRouter.swift
//  iTime
//
//  Created by 이상헌 on 2023/10/26.
//

import RIBs

import AppRoot
import LoggedOut
import LoggedIn

// MARK: - AppRootInteractable

protocol AppRootInteractable:
  Interactable,
  LoggedOutListener,
  LoggedInListener
{
  var router: AppRootRouting? { get set }
  var listener: AppRootListener? { get set }
}

// MARK: - AppRootViewControllable

protocol AppRootViewControllable: ViewControllable {
}

// MARK: - AppRootRouter

final class AppRootRouter:
  LaunchRouter<AppRootInteractable, AppRootViewControllable>,
  AppRootRouting
{
  private let loggedOutBuilder: LoggedOutBuildable
  private var loggedOutRouter: LoggedOutRouting?
  
  private let loggedInBuilder: LoggedInBuildable
  private var loggedInRouter: LoggedInRouting?
  
  init(
    interactor: AppRootInteractable,
    viewController: AppRootViewControllable,
    loggedOutBuilder: LoggedOutBuildable,
    loggedInBuilder: LoggedInBuildable
  ) {
    self.loggedOutBuilder = loggedOutBuilder
    self.loggedInBuilder = loggedInBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  func attachLoggedOut() {
    guard loggedOutRouter == nil else { return }
    let router = loggedOutBuilder.build(with: interactor)
    loggedOutRouter = router
    attachChild(router)
    viewController.presentFullScreen(
      router.viewControllable,
      animated: true,
      completion: nil
    )
  }
  
  func detachLoggedOut(_ completion: (() -> Void)? = nil) {
    guard let router = loggedOutRouter else { return }
    loggedOutRouter = nil
    detachChild(router)
    viewController.dismiss(
      animated: false,
      completion: completion
    )
  }
  
  func attachLoggedIn() {
    guard loggedInRouter == nil else { return }
    let router = loggedInBuilder.build(withListener: interactor)
    loggedInRouter = router
    attachChild(router)
    viewController.presentFullScreen(
      router.viewControllable,
      animated: false,
      completion: nil
    )
  }
  
  func detachLoggedIn() {
    guard let router = loggedInRouter else { return }
    loggedInRouter = nil
    detachChild(router)
    viewController.dismiss(
      router.viewControllable,
      animated: false,
      completion: nil
    )
  }
}
