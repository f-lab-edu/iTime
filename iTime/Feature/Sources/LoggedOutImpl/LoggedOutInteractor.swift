//
//  LoggedOutInteractor.swift
//  
//
//  Created by 이상헌 on 2023/10/31.
//

import RIBs
import RxSwift

import LoggedOut
import Usecase
import AppFoundation

protocol LoggedOutPresentable: Presentable {
  var listener: LoggedOutPresentableListener? { get set }
  func presentErrorMessage(_ message: String)
}

final class LoggedOutInteractor:
  PresentableInteractor<LoggedOutPresentable>,
  LoggedOutInteractable,
  LoggedOutPresentableListener
{
  
  weak var router: LoggedOutRouting?
  weak var listener: LoggedOutListener?
  
  private let authenticationUsecase: AuthenticationUsecase
  
  init(
    presenter: LoggedOutPresentable,
    authenticationUsecase: AuthenticationUsecase
  ) {
    self.authenticationUsecase = authenticationUsecase
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
  
  func requestAppleLogin() {
    authenticationUsecase.signIn()
      .subscribe(
        with: self,
        onSuccess: { this, _ in
          this.listener?.detachLoggedOut()
        }, onFailure: { this, error in
          this.presenter.presentErrorMessage(error.localizedDescription)
        }
      )
      .disposeOnDeactivate(interactor: self)
  }
}
