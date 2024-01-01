//
//  File.swift
//
//
//  Created by 이상헌 on 12/9/23.
//

import Start
import RIBs
import RxSwift

import RIBsTestSupport

// MARK: - LogEntryCreationRoutingSpy

public final class LogEntryCreationRoutingSpy: LogEntryCreationRouting {
  public func detachLogEntryEditorRIB() {
    
  }
  
  public func detachTimeLogRunningRIB() {
    
  }
  
  public func detachBookmarkEditorRIB() {
    
  }
  
  
  public var attachLogEntryEditorRIBCallCount: Int = 0
  public func attachLogEntryEditorRIB() {
    attachLogEntryEditorRIBCallCount += 1
  }
  
  public var attachBookmarkEditorRIbCallCount: Int = 0
  public func attachBookmarkEditorRIB() {
    attachBookmarkEditorRIbCallCount += 1
  }
  
  public var attachTimeLogRunningRIBCallCount: Int = 0
  public func attachTimeLogRunningRIB() {
    attachTimeLogRunningRIBCallCount += 1
  }
  
  public var viewControllable: RIBs.ViewControllable
  
  public var interactable: RIBs.Interactable
  
  public var children: [RIBs.Routing]
  
  public var loadCallCount: Int = 0
  public func load() {
    loadCallCount += 1
  }
  
  public var attachChildCallCount: Int = 0
  public func attachChild(_ child: RIBs.Routing) {
    attachChildCallCount += 1
  }
  
  public var detachChildCallCount: Int = 0
  public func detachChild(_ child: RIBs.Routing) {
    detachChildCallCount += 1
  }
  
  public var lifecycle: RxSwift.Observable<RIBs.RouterLifecycle>
  
  public init(
    viewControllable: RIBs.ViewControllable = ViewControllableMock(),
    interactable: RIBs.Interactable = Interactor(),
    children: [RIBs.Routing] = [],
    lifecycle: RxSwift.Observable<RIBs.RouterLifecycle> = .empty()
  ) {
    self.viewControllable = viewControllable
    self.interactable = interactable
    self.children = children
    self.lifecycle = lifecycle
  }
}
