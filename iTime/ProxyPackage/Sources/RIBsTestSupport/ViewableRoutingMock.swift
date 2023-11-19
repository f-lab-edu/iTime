//
//  File.swift
//
//
//  Created by 이상헌 on 11/19/23.
//

import RIBs
import RxSwift

open class ViewableRoutingMock: ViewableRouting {
  
  public var viewControllable: ViewControllable
  public var interactable: Interactable { didSet { interacatableSetCallCount += 1 } }
  public var interacatableSetCallCount = 0
  
  
  public var children: [Routing] = [Routing]() { didSet { } }
  public var childrenSetCallCount = 0
  
  public var lifecycleSubject = PublishSubject<RouterLifecycle>() {
    didSet {
      lifecycleSubjectSetCallCount += 1
    }
  }
  public var lifecycleSubjectSetCallCount = 0
  public var lifecycle: Observable<RouterLifecycle> { return lifecycleSubject.asObservable() }
  
  public init(
    interactable: Interactable,
    viewControllable: ViewControllable
  ) {
    self.interactable = interactable
    self.viewControllable = viewControllable
  }
  
  public var loadHandler: (() -> ())?
  public var loadCallCount = 0
  public func load() {
    loadCallCount += 1
    if let loadHandler = loadHandler {
      return
    }
  }
  
  public var attachChildHandler: ((_ child: Routing) -> ())?
  public var attachChildCallCount = 0
  public func attachChild(_ child: Routing) {
    attachChildCallCount += 1
    if let attachChildHandler = attachChildHandler {
      return attachChild(child)
    }
  }
  
  
  public var detachChildHandler: ((_ child: Routing) -> ())?
  public var detachChildCallCount = 0
  public func detachChild(_ child: Routing) {
    detachChildCallCount += 1
    if let detachChildHandler = detachChildHandler {
      return detachChild(child)
    }
  }
}
