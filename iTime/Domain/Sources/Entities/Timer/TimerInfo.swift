//
//  File.swift
//  
//
//  Created by 이상헌 on 12/9/23.
//

import Foundation
import AppFoundation

// MARK: - TimerInfo

public struct TimerInfo: PropertyBuilderCompatible, Equatable {
  public var lastlyForegroundTrackedDate: Date = Date()
  public var currentDate: Date = Date()
  public var runningTime: Int = Int()
  public var startTime: Int = Int()
  
  public init(lastlyForegroundTrackedDate: Date, currentDate: Date, runningTime: Int, startTime: Int) {
    self.lastlyForegroundTrackedDate = lastlyForegroundTrackedDate
    self.currentDate = currentDate
    self.runningTime = runningTime
    self.startTime = startTime
  }
  
  public init() {}
}
