//
//  LoggedInInteractor.swift
//  
//
//  Created by 이상헌 on 2023/11/02.
//

import RIBs
import RxSwift

protocol LoggedInPresentable: Presentable {
    var listener: LoggedInPresentableListener? { get set }
}

final class LoggedInInteractor:
  PresentableInteractor<LoggedInPresentable>,
  LoggedInInteractable,
  LoggedInPresentableListener
{

    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: LoggedInPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
