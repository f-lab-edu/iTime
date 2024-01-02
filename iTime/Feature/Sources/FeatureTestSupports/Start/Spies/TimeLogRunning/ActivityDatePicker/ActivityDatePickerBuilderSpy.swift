//
//  File.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import Start

public final class ActivityDatePickerBuilderSpy: ActivityDatePickerBuildable {
  
  public var buildHandler: ((_ listener: ActivityDatePickerListener) -> ActivityDatePickerRouting)?
  public var buildCallCount: Int = 0
  public func build(withListener listener: Start.ActivityDatePickerListener) -> Start.ActivityDatePickerRouting {
    buildCallCount += 1
    if let buildHandler = buildHandler {
      return buildHandler(listener)
    }
    
    fatalError()
  }
  
  public init() {}
}
