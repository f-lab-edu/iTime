//
//  File.swift
//  
//
//  Created by 이상헌 on 12/11/23.
//

import Foundation

import Repository

final class TimeSuspenseFacade {
  
  private let runningTimeTracker: RunningTimeTracker
  private let locationTracker: LocationTracker
  
  init(
    runningTimeTracker: RunningTimeTracker,
    locationTracker: LocationTracker
  ) {
    self.runningTimeTracker = runningTimeTracker
    self.locationTracker = locationTracker
  }
    
  func suspend() {
    runningTimeTracker.suspend()
    locationTracker.stopLocationTracking()
  }
}