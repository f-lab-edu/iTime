//
//  UIViewController+Util.swift
//  omos
//
//  Created by sangheon on 2023/04/09.
//

import UIKit

import RxSwift

public extension BaseViewController {
    
    func setupNavigationItem(with buttonType: DissmissButtonType ,target: Any? ,action: Selector?) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: buttonType.iconSystemName,
                           withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)),
            style: .plain,
            target: target,
            action: action
        )
    }
    
    func alert(_ message: String, completion: (()->Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .cancel) { (_) in
                completion?()
            }
            alert.addAction(okAction)
            self.present(alert, animated: false)
        }
    }
}

// MARK: 어떤 액션을 선택했는지 알기 위함
public enum ActionType {
    case ok
    case cancel
}
