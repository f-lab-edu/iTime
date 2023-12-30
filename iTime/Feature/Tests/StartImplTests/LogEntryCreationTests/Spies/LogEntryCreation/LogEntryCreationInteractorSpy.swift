//
//  File.swift
//  
//
//  Created by 이상헌 on 11/18/23.
//

import Foundation

import RxSwift
import RIBs

import Start
import RIBsTestSupport

@testable import StartImpl

final class LogEntryCreationInteratableSpy: LogEntryCreationInteractable {
  func detachLogEntryEditorRIB() {
    
  }
  
  func didTapTagCell(at index: IndexPath) {
    
  }
  
  func detachTimeLogRunningRIB() {
    
  }
  
  func detachBookmarkEditorRIB() {
    
  }
  
  func detachLocationEntryEditorRIB() {
  
  }
  
  func attachTimeLogRunningRIB() {
    
  }
  
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

final class LogEntryCreationViewControllableSpy:
  ViewControllableMock,
  LogEntryCreationViewControllable
{
  func addBookmarkList(_ view: RIBs.ViewControllable) {
   
  }
  
  func addLoggingRetention(_ view: RIBs.ViewControllable) {
   
  }
}

