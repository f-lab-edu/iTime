//
//  File.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//
import RxSwift

import RIBs

open class InteractableMock: Interactable {
  public var activateCallCount: Int = 0
  public func activate() {
    activateCallCount += 1
  }
  
  public var deactivateCallCount: Int = 0
  public func deactivate() {
    deactivateCallCount += 1
  }
  
  public var isActive: Bool { (try? isActiveSubject.value()) ?? false }
  
  public var isActiveStream: RxSwift.Observable<Bool> { isActiveSubject.asObservable() }
  
  public let isActiveSubject = BehaviorSubject(value: false)
  
  public init() {}
}
