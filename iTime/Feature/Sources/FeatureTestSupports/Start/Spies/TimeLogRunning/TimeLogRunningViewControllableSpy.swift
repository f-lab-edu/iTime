//
//  File.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import StartImpl
import RIBsTestSupport
import RIBs

public final class TimeLogRunningViewControllableSpy:
  ViewControllableMock,
  TimeLogRunningViewControllable {
  public var addCurrentActivityCallCount: Int = 0
  public func addCurrentActivity(_ view: RIBs.ViewControllable) {
    addCurrentActivityCallCount += 1
  }
  
  public var addCurrentTimerTimeCallCount: Int = 0
  public func addCurrentTimerTime(_ view: RIBs.ViewControllable) {
    addCurrentActivityCallCount += 1
  }
  
  public var addActivityDatePickerCallCount: Int = 0
  public func addActivityDatePicker(_ view: RIBs.ViewControllable) {
    addActivityDatePickerCallCount += 1
  }
  
  public var addTimerOperationCallCount: Int = 0
  public func addTimerOperation(_ view: RIBs.ViewControllable) {
    addTimerOperationCallCount += 1
  }
}
