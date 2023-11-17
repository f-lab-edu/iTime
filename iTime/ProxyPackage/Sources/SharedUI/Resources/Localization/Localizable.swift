//
//  File.swift
//  
//
//  Created by 이상헌 on 11/17/23.
//

import Foundation

// MARK: - Localizable

protocol Localizable {}

extension Localizable {
    func localizedText() -> String {
        let key = String(describing: self)
        return String(NSLocalizedString(key, comment: "\(key)_comment"))
    }
    
    func localizedText(with arguments: [CVarArg]) -> String {
        let key = String(describing: self)
        return String(format: NSLocalizedString(key, comment: "\(key)_comment"),
                      arguments: arguments)
    }
}
