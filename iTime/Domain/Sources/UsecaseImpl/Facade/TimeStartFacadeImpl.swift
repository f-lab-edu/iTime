//
//  File.swift
//
//
//  Created by 이상헌 on 12/11/23.
//

import RxSwift
import RxRelay

import Usecase
import Repository
import Entities
import AppFoundation

public final class TimeStartFacadeImpl: TimeStartFacade {
  
  private let locationTracker: LocationTracker
  private let runningTimeTracker: RunningTimeTracker
  private let timerInfoModelDataStream: TimerInfoModelDataStream
  private let userDefaultRepository: UserDefaultRepository
  
  public init(
    locationTracker: LocationTracker,
    runningTimeTracker: RunningTimeTracker,
    timerInfoModelDataStream: TimerInfoModelDataStream,
    userDefaultRepository: UserDefaultRepository
  ) {
    self.locationTracker = locationTracker
    self.runningTimeTracker = runningTimeTracker
    self.timerInfoModelDataStream = timerInfoModelDataStream
    self.userDefaultRepository = userDefaultRepository
  }
  
  public func start() -> Observable<Void> {
    Observable.combineLatest(
      Observable.just(runningTimeTracker.start()),
      runningTimeTracker.currentSeconds().debug("check")
    ) { $1 }
      .withUnretained(self)
      .map { owner, time in
        owner.timerInfoModelDataStream.updateRunningTime(with: time)
        owner.userDefaultRepository.updateLastlyTrackedTime(with: time)
      }
      .do(onSubscribe: { [weak self] in
        self?.locationTracker.startLocationTracking()
      })
  }
}
