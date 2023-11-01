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

protocol LoggedOutPresentable: Presentable {
  var listener: LoggedOutPresentableListener? { get set }
  func presentErrorMessage(_ message: String)
}

/// 의존성 감추기 용도
protocol ASAuthorizationContextProviding: Domain.ASAuthorizationContextProviding {}

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
  
  func requestAppleLogin(_ presenter: ASAuthorizationContextProviding) {
    authenticationUsecase.appleSignUp(presenter)
      .catch { [weak self] error in
        guard let self else { return .empty() }
        self.presenter.presentErrorMessage(error.localizedDescription)
        return .empty()
      }
      .subscribe(with: self) { owner, _ in
        owner.listener?.detachLoggedOut()
      }
      .disposeOnDeactivate(interactor: self)
  }
}
