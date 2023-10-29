//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/29.
//

import Foundation

import Platform

// MARK: - NotificationCenterSpy

final class NotificationCenterSpy:
    Postable,
    Addable
{
    
    var didPostNotificaitonWithName: String?
    func post(
        name aName: Notification.Name,
        object anObject: Any?
    ) {
        didPostNotificaitonWithName = aName.rawValue
    }
    
    var didAddObserverWithName: String?
    func addObserver(
        forName name: NSNotification.Name?,
        object obj: Any?,
        queue: OperationQueue?,
        using block: @escaping @Sendable (Notification) -> Void) -> NSObjectProtocol
    {
        didAddObserverWithName = name?.rawValue
        
        return NSObject()
    }

    var didCallRemoveObserverWithName = false
    func removeObserver(_ observer: Any) {
        didCallRemoveObserverWithName = true
    }
}
