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

final class LogEntryCreationRoutingSpy: LogEntryCreationRouting {
  
  public var attachLogEntryEditorRIBCallCount: Int = 0
  func attachLogEntryEditorRIB() {
    attachLogEntryEditorRIBCallCount += 1
  }
  
  public var attachBookmarkEditorRIbCallCount: Int = 0
  func attachBookmarkEditorRIB() {
    attachBookmarkEditorRIbCallCount += 1
  }
  
  public var attachTimeLogRunningRIBCallCount: Int = 0
  func attachTimeLogRunningRIB() {
    attachTimeLogRunningRIBCallCount += 1
  }
  
  var viewControllable: RIBs.ViewControllable
  
  var interactable: RIBs.Interactable
  
  var children: [RIBs.Routing]
  
  public var loadCallCount: Int = 0
  func load() {
    loadCallCount += 1
  }
  
  public var attachChildCallCount: Int = 0
  func attachChild(_ child: RIBs.Routing) {
    attachChildCallCount += 1
  }
  
  public var detachChildCallCount: Int = 0
  func detachChild(_ child: RIBs.Routing) {
    detachChildCallCount += 1
  }
  
  var lifecycle: RxSwift.Observable<RIBs.RouterLifecycle>
  
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
