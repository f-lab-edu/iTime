//
//  File.swift
//  
//
//  Created by 이상헌 on 2/24/24.
//

import Editor
import RIBsTestSupport

public class CategoryListBuilderSpy: CategoryListBuildable {
  
  public var buildHandler: ((_ listener: CategoryListListener) -> CategoryListRouting)?
  
  public func build(withListener listener: CategoryListListener) -> CategoryListRouting {
    if let buildHandler = buildHandler {
      return buildHandler(listener)
    }
    
    fatalError()
  }
  
  public init() {}
}


