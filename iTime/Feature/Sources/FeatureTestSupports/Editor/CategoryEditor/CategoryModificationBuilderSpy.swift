//
//  File.swift
//  
//
//  Created by 이상헌 on 3/10/24.
//

import Editor
import RIBsTestSupport

public class CategoryModificationBuilderSpy: CategoryModificationBuildable {
  
  public var buildHandler: ((_ listener: CategoryModificationListener) -> CategoryModificationRouting)?
  
  public func build(withListener listener: CategoryModificationListener) -> CategoryModificationRouting {
    if let buildHandler = buildHandler {
      return buildHandler(listener)
    }
    
    fatalError()
  }
  
  public init() {}
}


