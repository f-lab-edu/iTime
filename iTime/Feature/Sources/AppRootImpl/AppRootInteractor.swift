//
//  AppRootInteractor.swift
//  iTime
//
//  Created by 이상헌 on 2023/10/26.
//
import OSLog

import RIBs

import AppRoot
import Usecase
import AppFoundation

// MARK: - AppRootPresentable

protocol AppRootPresentable: Presentable {
  var listener: AppRootPresentableListener? { get set }
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
  private let timeLogUsecase: TimeLogUsecase
  
  init(
    presenter: AppRootPresentable,
    timeLogUsecase: TimeLogUsecase,
    authenticationUsecase: AuthenticationUsecase
  ) {
    self.authenticationUsecase = authenticationUsecase
    self.timeLogUsecase = timeLogUsecase
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    routeInitalLaunch()
    loadData()
  }
  
  private func routeInitalLaunch() {
    authenticationUsecase.isLoggedIn() ?
    router?.attachLoggedIn() :
    router?.attachLoggedOut()
  }
  
  private func loadData() {
    _ = timeLogUsecase.preLoadAllData()
      .subscribe(with: self) { owner, _ in
        os_log(.debug, log: .presenter, "preLoadData is success")
      } onFailure: { owner, error in
        os_log(.error, log: .presenter, "%@", error.localizedDescription)
      }
  }
  
  func detachLoggedOut() {
    router?.detachLoggedOut { [weak self] in
      self?.router?.attachLoggedIn()
    }
  }
}

