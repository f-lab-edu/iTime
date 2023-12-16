//
//  File.swift
//
//
//  Created by 이상헌 on 12/16/23.
//

import RxSwift

import Usecase
import AppFoundation

public final class TimeLogUsecaseMonitoringDecorator: TimeLogUsecase {
  private let decoratee: TimeLogUsecase
  private let logger: FirebaseAnalyticsLogger
  
  public init(
    decoratee: TimeLogUsecase,
    logger: FirebaseAnalyticsLogger
  ) {
    self.decoratee = decoratee
    self.logger = logger
  }
  
  public func preLoadAllData() -> Single<Void> {
    logger.LogPreLoadAllData()
    return decoratee.preLoadAllData()
  }
}
