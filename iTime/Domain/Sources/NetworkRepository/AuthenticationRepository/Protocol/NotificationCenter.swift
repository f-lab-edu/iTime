//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/29.
//

import Foundation

// MARK: - Postable

public protocol Postable {
    func post(name aName: NSNotification.Name, object anObject: Any?)
}

// MARK: - Addable

public protocol Addable {
    @discardableResult
    func addObserver(
        forName name: NSNotification.Name?,
        object obj: Any?,
        queue: OperationQueue?,
        using block: @escaping @Sendable (Notification) -> Void) -> NSObjectProtocol
    func removeObserver(_ observer: Any)
}

extension NotificationCenter: Postable, Addable {}
