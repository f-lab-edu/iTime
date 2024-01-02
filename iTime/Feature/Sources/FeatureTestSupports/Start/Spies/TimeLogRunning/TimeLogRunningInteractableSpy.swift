//
//  File.swift
//
//
//  Created by 이상헌 on 1/2/24.
//

import RxSwift

import StartImpl
import Start

public final class TimeLogRunningInteractableSpy: TimeLogRunningInteractable {
  public var routerSetCallCount: Int = 0
  public var router: Start.TimeLogRunningRouting? { didSet { self.routerSetCallCount += 1 }}
  public var listenerSetCallCount: Int = 0
  public var listener: Start.TimeLogRunningListener? { didSet { listenerSetCallCount += 1 }}
   
  public var activateCallCount: Int = 0
  public func activate() {
    activateCallCount += 1
  }
  
  public var deactivateCallCount: Int = 0
  public func deactivate() {
    deactivateCallCount += 1
  }
  
  public var detachTimeLogRunningRIBCallCount: Int = 0
  public func detachTimeLogRunningRIB() {
    detachTimeLogRunningRIBCallCount += 1
  }
  
  public var isActive: Bool { (try? isActiveSubject.value()) ?? false}
  
  public var isActiveStream: RxSwift.Observable<Bool> { isActiveSubject.asObservable() }
  
  private let isActiveSubject = BehaviorSubject(value: false)
  
  public init() {}
}
