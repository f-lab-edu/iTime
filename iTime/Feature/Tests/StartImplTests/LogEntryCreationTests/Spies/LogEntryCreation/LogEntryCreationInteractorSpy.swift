//
//  File.swift
//  
//
//  Created by 이상헌 on 12/9/23.
//
import RxSwift
import Start
@testable import StartImpl

final class LogEntryCreationInteractorSpy: LogEntryCreationInteractable {
  var router: LogEntryCreationRouting?
  
  var listener: LogEntryCreationListener?
  
  func activate() {
    
  }
  
  func deactivate() {
    
  }
  
  func detachLocationEntryEditorRIB() {
    
  }
  
  func attachTimeLogRunningRIB() {
    
  }
  
  var isActive: Bool = false
  
  var isActiveStream: RxSwift.Observable<Bool> = .empty()
  
  init(router: LogEntryCreationRouting? = nil, listener: LogEntryCreationListener? = nil, isActive: Bool, isActiveStream: RxSwift.Observable<Bool>) {
    self.router = router
    self.listener = listener
    self.isActive = isActive
    self.isActiveStream = isActiveStream
  }
}
