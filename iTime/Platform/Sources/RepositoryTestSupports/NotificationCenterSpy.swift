//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/29.
//

import Foundation

import AuthenticationRepository

// MARK: - NotificationCenterSpy

public final class NotificationCenterSpy:
    Postable,
    Addable
{
    
    var didPostNotificaitonWithName: String?
    public func post(
        name aName: Notification.Name,
        object anObject: Any?
    ) {
        didPostNotificaitonWithName = aName.rawValue
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delaySeconds, execute: {
            NotificationCenter.default.post(
                name: aName,
                object: anObject
            )
        })
    }
    
    var didAddObserverWithName: String?
    public func addObserver(
        forName name: NSNotification.Name?,
        object obj: Any?,
        queue: OperationQueue?,
        using block: @escaping @Sendable (Notification) -> Void) -> NSObjectProtocol
    {
        didAddObserverWithName = name?.rawValue
        
        return NotificationCenter.default.addObserver(
            forName: name,
            object: obj,
            queue: queue,
            using: block
        )
    }

    var didCallRemoveObserverWithName = false
    public func removeObserver(_ observer: Any) {
        didCallRemoveObserverWithName = true
        
        NotificationCenter.default.removeObserver(observer)
    }
    
    private var delaySeconds: DispatchTimeInterval = .seconds(0)
    public init(delaySeconds: Int) {
        self.delaySeconds = DispatchTimeInterval.seconds(delaySeconds)
    }
}
