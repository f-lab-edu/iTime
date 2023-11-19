//
//  File.swift
//  
//
//  Created by 이상헌 on 11/18/23.
//

import RxSwift

import Start
import RIBsTestSupport

@testable import StartImpl

final class LogEntryCreationInteratableMock: LogEntryCreationInteractable {
  var router: LogEntryCreationRouting?
  var listener: LogEntryCreationListener?
  
  public func activate() {
    
  }
  
  public func deactivate() {
    
  }
  
  public var isActive: Bool { (try? isActiveSubject.value()) ?? false }
  
  public var isActiveStream: Observable<Bool> { isActiveSubject.asObservable()}
  
  private let isActiveSubject = BehaviorSubject<Bool>(value: false)
}

final class LogEntryCreationViewControllableMock: ViewControllableMock, LogEntryCreationViewControllable {
  
}

