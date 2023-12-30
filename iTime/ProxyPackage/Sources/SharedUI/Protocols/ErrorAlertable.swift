//
//  File.swift
//
//
//  Created by 이상헌 on 12/17/23.
//

import UIKit
import AppFoundation

public protocol ErrorAlertable: UIViewController {
  func showErrorAlert(with displayErrorAlert: DisplayErrorMessage)
  func makeErrorAlert(with displayErrorAlert: DisplayErrorMessage) -> UIAlertController
}

extension ErrorAlertable {
  public func showErrorAlert(with displayErrorAlert: DisplayErrorMessage) {
    let alert = makeErrorAlert(with: displayErrorAlert)
    present(alert, animated: true)
  }
  
  public func makeErrorAlert(with displayErrorAlert: DisplayErrorMessage) -> UIAlertController {
    let alert = UIAlertController(
      title: displayErrorAlert.title,
      message: displayErrorAlert.message,
      preferredStyle: .alert
    )
    
    let confirmAction = UIAlertAction(title: displayErrorAlert.confirmActionTitle, style: .cancel)
    alert.addAction(confirmAction)
    
    return alert
  }
}
