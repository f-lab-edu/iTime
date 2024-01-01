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
import Entities
import RIBsTestSupport

@testable import StartImpl

public final class LogEntryCreationInteratableSpy: LogEntryCreationInteractable {
  public func didTapTagCell(_ bookmark: Bookmark) {
    
  }
  
  public func detachLogEntryEditorRIB() {
    
  }
  
  public func detachTimeLogRunningRIB() {
    
  }
  
  public func detachBookmarkEditorRIB() {
    
  }
  
  public func attachTimeLogRunningRIB() {
    
  }
  
  public var router: LogEntryCreationRouting?
  public var listener: LogEntryCreationListener?
  
  public func activate() {
    
  }
  
  public func deactivate() {
    
  }
  
  public var isActive: Bool { (try? isActiveSubject.value()) ?? false }
  
  public var isActiveStream: Observable<Bool> { isActiveSubject.asObservable()}
  
  private let isActiveSubject = BehaviorSubject<Bool>(value: false)
  
  public init() {}
}

public final class LogEntryCreationViewControllableSpy:
  ViewControllableMock,
  LogEntryCreationViewControllable
{
  public func addBookmarkList(_ view: RIBs.ViewControllable) {
   
  }
  
  public func addLoggingRetention(_ view: RIBs.ViewControllable) {
   
  }
}

