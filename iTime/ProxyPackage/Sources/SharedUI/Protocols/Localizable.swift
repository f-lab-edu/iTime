//
//  File.swift
//
//
//  Created by 이상헌 on 11/17/23.
//

import Foundation

// MARK: - Localizable

public protocol Localizable {}

extension Localizable {
  public func localizedText() -> String {
    let key = String(describing: self)
    return String(NSLocalizedString(key, bundle: Bundle.module, comment: "\(key)_comment"))
  }
  
  public func localizedText(with arguments: [CVarArg]) -> String {
    let key = String(describing: self)
    return String(format: NSLocalizedString(key, bundle: Bundle.module, comment: "\(key)_comment"),
                  arguments: arguments)
  }
}
