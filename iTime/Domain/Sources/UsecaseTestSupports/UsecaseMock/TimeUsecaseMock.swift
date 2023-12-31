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
  public func start() -> RxSwift.Observable<Void> {
    return .just(Void())
  }
  
  public func suspend() {
    
  }
  
  public func finish(_ activity: Entities.Activity) -> RxSwift.Observable<Void> {
    return .empty()
  }
  
  public init() {}
}
