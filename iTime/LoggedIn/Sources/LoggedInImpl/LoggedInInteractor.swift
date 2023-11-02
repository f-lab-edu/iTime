//
//  LoggedInInteractor.swift
//  
//
//  Created by 이상헌 on 2023/11/02.
//

import RIBs
import RxSwift

import LoggedIn

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
  
  override init(presenter: LoggedInPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    self.router?.attachTabs()
  }
}
