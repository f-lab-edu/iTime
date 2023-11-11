//
//  HasAlertable.swift
//  omos
//
//  Created by sangheon on 2023/05/27.
//

import RxSwift

import UIKit
 
public protocol HasAlertable: AnyObject {
    func showAlert(title: String, message: String?, isNeedCancel: Bool) -> Observable<ActionType>
}

public extension HasAlertable where Self: UIViewController {
    func showAlert(title: String, message: String? = nil, isNeedCancel: Bool = false) -> Observable<ActionType> {
        return Observable.create { [weak self] observer in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            if isNeedCancel {
                let cancelAction = UIAlertAction(title: "닫기", style: .default) { (_) in }
                alertController.addAction(cancelAction)
            }
            let okAction = UIAlertAction(title: "확인", style: .default) { _ in
                // event 전달
                observer.onNext(.ok)
                observer.onCompleted()
            }
            alertController.addAction(okAction)
            
            self?.present(alertController, animated: true, completion: nil)
            
            return Disposables.create {
                alertController.dismiss(animated: true, completion: nil)
            }
        }
    }
}

