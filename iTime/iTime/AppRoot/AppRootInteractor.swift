//
//  AppRootInteractor.swift
//  iTime
//
//  Created by 이상헌 on 2023/10/26.
//

import RIBs

import Domain

// MARK: - AppRootRouting

protocol AppRootRouting: ViewableRouting {
  func attachLoggedOut()
  func detachLoggedOut(_ completion: (() -> Void)?)
  func attachLoggedIn()
  func detachLoggedIn()
}

// MARK: - AppRootPresentable

protocol AppRootPresentable: Presentable {
  var listener: AppRootPresentableListener? { get set }
}

// MARK: - AppRootListener

protocol AppRootListener: AnyObject {
}

// MARK: - AppRootInteractor

final class AppRootInteractor:
  PresentableInteractor<AppRootPresentable>,
  AppRootInteractable,
  AppRootPresentableListener
{
  
  weak var router: AppRootRouting?
  weak var listener: AppRootListener?
  
  private let authenticationUsecase: AuthenticationUsecase
  
  init(
    presenter: AppRootPresentable,
    authenticationUsecase: AuthenticationUsecase
  ) {
    self.authenticationUsecase = authenticationUsecase
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    routeInitalLaunch()
  }
  
  private func routeInitalLaunch() {
    authenticationUsecase.isLoggedIn() ?
    router?.attachLoggedIn() :
    router?.attachLoggedOut()
  }
  
  func detachLoggedOut() {
    router?.detachLoggedOut { [weak self] in
      self?.router?.attachLoggedIn()
    }
  }
}

