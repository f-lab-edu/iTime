//
//  File.swift
//  
//
//  Created by 이상헌 on 12/8/23.
//

import Start
@testable import StartImpl

// MARK: - LogEntryCreationPresentableSpy

public final class LogEntryCreationPresentableSpy: LogEntryCreationPresentable {
  public init(listener: LogEntryCreationPresentableListener? = nil) {
      self.listener = listener
  }
  
  public private(set) var listenerSetCallCount = 0
  public var listener: LogEntryCreationPresentableListener? { didSet { self.listenerSetCallCount += 1 } }
}
