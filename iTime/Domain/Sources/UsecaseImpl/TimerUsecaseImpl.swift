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

final class TimerUsecaseImpl: TimerUsecase {
  
  // MARK: - Properties
  
  private let timeLogRecordRelay = BehaviorRelay(value: TimeLogRecord())
  private var timeLogRecordRelayBuilder: PropertyBuilder<TimeLogRecord> { timeLogRecordRelay.value.builder }
  
  private let locationTracker: LocationTracker
  private let runningTimeTracker: RunningTimeTracker
  private let userDefaultRepository: UserDefaultRepository
  private let timeLogRecordRepository: TimeLogRecordRepository
  private let mutableTimerInfoModelDataStream: MutableTimerInfoModelDataStream
  private let mutableTimeLogRecordModelDataStream: MutableTimeLogRecordModelDataStream
  
  // MARK: - Initialization
  
  init(
    locationTracker: LocationTracker,
    runningTimeTracker: RunningTimeTracker,
    userDefaultRepository: UserDefaultRepository,
    timeLogRecordRepository: TimeLogRecordRepository,
    mutableTimerInfoModelDataStream: MutableTimerInfoModelDataStream,
    mutableTimeLogRecordModelDataStream: MutableTimeLogRecordModelDataStream
  ) {
    self.locationTracker = locationTracker
    self.runningTimeTracker = runningTimeTracker
    self.userDefaultRepository = userDefaultRepository
    self.timeLogRecordRepository = timeLogRecordRepository
    self.mutableTimerInfoModelDataStream = mutableTimerInfoModelDataStream
    self.mutableTimeLogRecordModelDataStream = mutableTimeLogRecordModelDataStream
  }
  
  func start() -> Observable<Void> {
    runningTimeTracker.currentTimerTime()
      .filter { $0 != .zero }
      .withUnretained(self)
      .map { owner, time in
        owner.mutableTimerInfoModelDataStream.updateRunningTime(with: time)
        owner.userDefaultRepository.updateLastlyTrackedTime(with: time)
      }
      .do(onSubscribe: { [weak self] in
        self?.runningTimeTracker.initiateTimerIfNeeded()
      })
  }
  
  func stop() {
    runningTimeTracker.stopTimer()
  }
  
  func save(_ activity: Activity) -> Observable<Void> {
    defer {
      runningTimeTracker.resetTimer()
    }
    
    return .merge(
      .just(saveID()),
      .just(saveActivity(activity)),
      saveCurrentLocation(),
      saveDate()
    )
  }
  
  // MARK: - Privates
  
  private func saveID() {
    timeLogRecordRelay.accept(
      timeLogRecordRelayBuilder
        .id(UUID().uuidString)
    )
  }
  
  private func saveActivity(_ activity: Activity) {
    timeLogRecordRelay.accept(
      timeLogRecordRelayBuilder
        .activity(activity)
    )
  }
  
  private func saveCurrentLocation() -> Observable<Void> {
    locationTracker.currentUserLocation()
      .withUnretained(self)
      .map { owner, location in
        owner.timeLogRecordRelay.accept(owner.timeLogRecordRelayBuilder.coordinate(Coordinate2D(location)))
      }
  }
  
  private func saveDate() -> Observable<Void> {
    mutableTimerInfoModelDataStream.timerInfoModelDataStream.map(\.runningTime)
      .withUnretained(self)
      .map { owner, time in
        guard let startDate = owner.runningTimeTracker.getStartDate() else {
          assertionFailure("cannot find startTime")
          return
        }
        guard let dateComponentSecond = Calendar.current.dateComponents([.hour, .minute, .second], from: startDate).second else {
          return
        }
        let endDate = startDate.addingTimeInterval(Double(dateComponentSecond + time))
        owner.timeLogRecordRelay.accept(
          owner.timeLogRecordRelayBuilder
            .startDate("\(startDate)")
            .endDate("\(endDate)")
        )
      }
  }
}
