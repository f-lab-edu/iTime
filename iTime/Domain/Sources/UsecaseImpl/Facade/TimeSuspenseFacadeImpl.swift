//
//  File.swift
//  
//
//  Created by 이상헌 on 12/11/23.
//

import Usecase
import Repository

public final class TimeSuspenseFacadeImpl: TimeSuspenseFacade {
  
  private let runningTimeTracker: RunningTimeTracker
  private let locationTracker: LocationTracker
  
  public init(
    runningTimeTracker: RunningTimeTracker,
    locationTracker: LocationTracker
  ) {
    self.runningTimeTracker = runningTimeTracker
    self.locationTracker = locationTracker
  }
    
  public func suspend() {
    runningTimeTracker.suspend()
    locationTracker.stopLocationTracking()
  }
}
