//
//  File.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import Foundation
import StartImpl

public final class TimeLogRunningPresentableSpy: TimeLogRunningPresentable {
  public var listenerSetCallCount: Int = 0
  public var listener: TimeLogRunningPresentableListener? { didSet { self.listenerSetCallCount += 1 }}
  public init() {}
}
