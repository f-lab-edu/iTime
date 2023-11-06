//
//  LoggedOutInteractor.swift
//  
//
//  Created by 이상헌 on 2023/10/31.
//

import RIBs
import RxSwift

import Domain
import LoggedOut
import ProxyPackage

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
      .catch { [weak self] error in
        guard let self else { return .empty() }
        self.presenter.presentErrorMessage(error.localizedDescription)
        return .empty()
      }
      .subscribe(with: self) { this, _ in
        this.listener?.detachLoggedOut()
      }
      .disposeOnDeactivate(interactor: self)
  }
}
