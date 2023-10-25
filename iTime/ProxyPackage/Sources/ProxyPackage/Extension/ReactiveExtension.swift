//
//  ReactiveExtension.swift
//  omos
//
//  Created by sangheon on 2023/05/17.
//
import UIKit

import RxSwift
import RxCocoa
import RxGesture

extension ObservableType {
    public func preventDuplication(milliseconds: Int = 300) -> Observable<Element> {
        return asObservable().throttle(.milliseconds(milliseconds),
                                       latest: false,
                                       scheduler: MainScheduler.asyncInstance)
    }
}

extension Reactive where Base: RxGestureView {
    public func tapGestureWithPreventDuplication(dueTime: Int = 300) -> Observable<UITapGestureRecognizer> {
        return tapGesture().when(.recognized).preventDuplication(milliseconds: dueTime)
    }
}

extension Reactive where Base: UIButton {
    public func tapWithPreventDuplication(dueTime: Int = 300) -> Observable<Void> {
        return tap.preventDuplication(milliseconds: dueTime)
    }
}

extension ObservableType {
    func mapChangedRevisionValue<T> (_ transform: @escaping (Self.Element) throws -> ReactorValue<T>) -> Observable<T> {
        return self
            .map(transform)
            .distinctUntilChanged { $0.revision == $1.revision }
            .map { $0.value }
    }
}
