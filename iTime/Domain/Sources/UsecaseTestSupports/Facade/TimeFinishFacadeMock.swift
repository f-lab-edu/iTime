//
//  File.swift
//  
//
//  Created by 이상헌 on 12/15/23.
//

import RxSwift

import Entities
import Usecase

public final class TimeFinishFacadeMock: TimeFinishFacade {
  
  public var record: TimeLogRecord?
  
  public var finishCallCount: Int = 0
  public func finish(_ record: Entities.TimeLogRecord) -> RxSwift.Observable<Void> {
    finishCallCount += 1
    self.record = record
    return .just(Void())
  }
  
  public init() {}
}
