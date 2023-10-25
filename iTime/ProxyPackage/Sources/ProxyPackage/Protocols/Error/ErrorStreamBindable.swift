//
//  ErrorStreamBindable.swift
//  omos
//
//  Created by sangheon on 2023/05/27.
//

import RxSwift

public protocol ErrorStreamBindable: AnyObject {
    func bindErrorStream(from listener: HasErrorStream)
}

public extension ErrorStreamBindable where Self: BaseViewController & HasAlertable & HasDisposeBag {
    func bindErrorStream(from listener: HasErrorStream) {
        listener.myErrorStream
            .distinctUntilChanged()
            .map(\.value)
            .filter({ $0 != .noError })
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .flatMap { owner, myError in owner.showAlert(title: myError.title, message: myError.messaage)}
            .subscribe()
            .disposed(by: disposeBag)
    }
}
