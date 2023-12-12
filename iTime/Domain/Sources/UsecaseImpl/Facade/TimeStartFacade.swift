//
//  File.swift
//
//
//  Created by 이상헌 on 12/11/23.
//

import RxSwift
import RxRelay

import Repository
import Entities
import AppFoundation

public final class TimeStartFacade {
  
  private let locationTracker: LocationTracker
  private let runningTimeTracker: RunningTimeTracker
  private let timerInfoModelDataStream: TimerInfoModelDataStream
  private let userDefaultRepository: UserDefaultRepository
  
  init(
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
  
  func start() -> Observable<Void> {
    runningTimeTracker.currentSeconds()
      .filter { $0 != .zero }
      .withUnretained(self)
      .map { owner, time in
        owner.locationTracker.startLocationTracking()
        owner.timerInfoModelDataStream.updateRunningTime(with: time)
        owner.userDefaultRepository.updateLastlyTrackedTime(with: time)
      }
  }
}
