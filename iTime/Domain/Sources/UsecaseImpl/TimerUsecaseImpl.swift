//
//  File.swift
//
//
//  Created by 이상헌 on 12/9/23.
//

import Foundation

import RxSwift
import RxRelay

import Repository
import Entities
import Usecase
import AppFoundation

public final class TimerUsecaseImpl: TimerUsecase {
  
  // MARK: - Properties
  
  private let timeLogRecordBuilder: TimeLogRecordBuilder
  
  private let timeStartFacade: TimeStartFacade
  private let timeSuspenseFacade: TimeSuspenseFacade
  private let timeFinishFacade: TimeFinishFacade
  
  // MARK: - Initialization
  
  public init(
    timeLogRecordBuilder: TimeLogRecordBuilder,
    timeStartFacade: TimeStartFacade,
    timeSuspenseFacade: TimeSuspenseFacade,
    timeFinishFacade: TimeFinishFacade
  ) {
    self.timeLogRecordBuilder = timeLogRecordBuilder
    self.timeStartFacade = timeStartFacade
    self.timeSuspenseFacade = timeSuspenseFacade
    self.timeFinishFacade = timeFinishFacade
  }
  
  public func start() -> Observable<Void> {
    timeStartFacade.start()
  }
  
  public func suspend() {
    timeSuspenseFacade.suspend()
  }
  
  public func finish(_ activity: Activity) -> Observable<Void> {
    timeLogRecordBuilder.timeLogRecord(
      activity: activity
    )
    .withUnretained(self)
    .flatMap { owner, record in
      owner.timeFinishFacade.finish(record)
    }
    .debug("shlee")
  }
  
}
