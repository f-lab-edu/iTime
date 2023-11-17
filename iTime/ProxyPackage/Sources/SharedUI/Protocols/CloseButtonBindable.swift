//
//  File.swift
//
//
//  Created by 이상헌 on 11/13/23.
//

import RxSwift

// MARK: - CloseButtonBindable

public protocol CloseButtonBindable {
  func bindCloseButtonTapAction()
}

extension CloseButtonBindable where Self: HasCloseButtonHeaderView & HasDetachAction & HasDisposeBag {
  public func bindCloseButtonTapAction() {
    headerView.closeButton.rx.tap
      .throttle(.seconds(1), latest: false, scheduler: MainScheduler.instance)
      .bind(to: detachAction)
      .disposed(by: disposeBag)
  }
}

