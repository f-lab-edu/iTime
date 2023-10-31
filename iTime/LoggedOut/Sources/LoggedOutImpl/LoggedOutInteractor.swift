//
//  LoggedOutInteractor.swift
//  
//
//  Created by 이상헌 on 2023/10/31.
//

import RIBs
import RxSwift

import Domain
import Platform
import LoggedOut

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
}

// MARK: - Mutation

extension LoggedOutInteractor {
    func requestAppleLogin(_ presenter: ASAuthorizationContextProviding) {
        authenticationUsecase.appleSignUp(presenter)
            .catch { [weak self] error in
                guard let self else { return .empty() }
                self.presenter.presentErrorMessage(error.localizedDescription)
                return .empty()
            }
            .subscribe(with: self) { owner, _ in
                print("APPLE Login Success")
            }
            .disposeOnDeactivate(interactor: self)
    }
}
