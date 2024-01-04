//
//  File.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RxSwift

import Entities
import Usecase

public class TimerUsecaseMock: TimerUsecase {
  
  public var startCallCount: Int = 0
  public func start() {
    startCallCount += 1
  }
  
  public var suspendCallCount: Int = 0
  public func suspend() {
    suspendCallCount += 1
  }
  
  public var finishCallCount: Int = 0
  public var activityValue: Activity = .empty
  public func finish(_ activity: Entities.Activity) -> RxSwift.Observable<Void> {
    finishCallCount += 1
    activityValue = activity
    return .just(Void())
  }
  
  public init() {}
}
