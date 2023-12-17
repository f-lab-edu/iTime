//
//  File.swift
//
//
//  Created by 이상헌 on 12/11/23.
//

import Foundation

import RxRelay
import RxSwift

import Entities
import Repository
import AppFoundation

public final class TimeLogRecordBuilder {
  
  // MARK: - Properties
  
  private let timeLogRecordRelay = BehaviorRelay(value: TimeLogRecord())
  private var timeLogRecordRelayBuilder: PropertyBuilder<TimeLogRecord> { timeLogRecordRelay.value.builder }
  
  private let locationTracker: LocationTracker
  private let runningTimeTracker: RunningTimeTracker
  private let timerInfoModelDataStream: TimerInfoModelDataStream
  
  // MARK: Initialization
  
  public init(
    locationTracker: LocationTracker,
    runningTimeTracker: RunningTimeTracker,
    timerInfoModelDataStream: TimerInfoModelDataStream
  ) {
    self.locationTracker = locationTracker
    self.runningTimeTracker = runningTimeTracker
    self.timerInfoModelDataStream = timerInfoModelDataStream
  }
  
  func timeLogRecord(activity: Activity) -> Observable<TimeLogRecord> {
    Observable<Void>.zip(
      Observable.just(saveID()),
      Observable.just(saveActivity(activity)),
      saveCurrentLocation(),
      saveDate()
    ) { _,_,_,_  in return Void() }
    .flatMap(timeLogRecordRelay.asObservable)
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
        owner.locationTracker.stopLocationTracking()
        return owner.timeLogRecordRelay.accept(owner.timeLogRecordRelayBuilder.coordinate(Coordinate2D(location)))
      }
  }
  
  private func saveDate() -> Observable<Void> {
    timerInfoModelDataStream.timerInfoModelDataStream.map(\.runningTime)
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
