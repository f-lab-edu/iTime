//
//  KeyboardUsable.swift
//  TaxiDispatch
//
//  Created by sangheon on 2023/08/20.
//

import UIKit

public protocol KeyboardAddable {
  func addKeyboardObserver()
  func removeKeyboardObserver()
}

extension KeyboardAddable where Self: BaseViewController {
  public func addKeyboardObserver() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillShow),
                                           name: UIApplication.keyboardWillShowNotification,
                                           object: nil)
    
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(keyboardWillHide),
                                           name: UIApplication.keyboardWillHideNotification,
                                           object: nil)
  }
  
  public func removeKeyboardObserver() {
    NotificationCenter.default.removeObserver(self,
                                              name: UIApplication.keyboardWillShowNotification,
                                              object: nil)
    NotificationCenter.default.removeObserver(self,
                                              name: UIApplication.keyboardWillHideNotification,
                                              object: nil)
  }
  
}
