//
//  AppRootInteractor.swift
//  iTime
//
//  Created by 이상헌 on 2023/10/26.
//

import RIBs

// MARK: - AppRootRouting

protocol AppRootRouting: ViewableRouting {
    func attachLoggedOut()
    func detachLoggedOut()
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

    override init(presenter: AppRootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        router?.attachLoggedOut()
    }
}

