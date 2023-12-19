//
//  File.swift
//  
//
//  Created by 이상헌 on 12/15/23.
//

import RxSwift

import Usecase

public final class TimeStartFacadeMock: TimeStartFacade {
  
  public var startCallCount: Int = 0
  public func start() -> Observable<Void> {
    startCallCount += 1
    return .just(Void())
  }

  public init() {}
}



