//
//  KeyboardUsable.swift
//  TaxiDispatch
//
//  Created by sangheon on 2023/08/20.
//

import UIKit

protocol KeyboardAddable {
    func addKeyboardObserver()
    func removeKeyboardObserver()
}

extension KeyboardAddable where Self: BaseViewController {
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIApplication.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIApplication.keyboardWillHideNotification,
                                               object: nil)
    }
    
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIApplication.keyboardWillHideNotification,
                                                  object: nil)
    }
    
}
