//
//  File.swift
//  
//
//  Created by 이상헌 on 2/24/24.
//

import Editor

public final class CategoryCreationBuilderSpy: CategoryCreationBuildable {
  
  public var buildHandler: ((_ listener: CategoryCreationListener) -> CategoryCreationRouting)?
  
  public var buildCallCount: Int = 0
  public func build(withListener listener: CategoryCreationListener) -> CategoryCreationRouting {
    buildCallCount += 1
    if let buildHandler = buildHandler {
      return buildHandler(listener)
    }
    
    fatalError()
  }
  
  public init() {}
}
