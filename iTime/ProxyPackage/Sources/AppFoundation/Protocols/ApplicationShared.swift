//
//  File.swift
//  
//
//  Created by 이상헌 on 12/12/23.
//

import UIKit.UIApplication

// MARK: - ApplicationShared

public protocol ApplicationShared {
  func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler completion: ((Bool) -> Void)?)
}

extension UIApplication: ApplicationShared {}
