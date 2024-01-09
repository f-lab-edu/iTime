//
//  File.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import StartImpl

public final class ActivityDatePickerPresentableSpy: ActivityDatePickerPresentable {
  public var listenerSetCallCount: Int = 0
  public var listener: StartImpl.ActivityDatePickerPresentableListener? { didSet { self.listenerSetCallCount += 1 }}
  public init() {}
}
