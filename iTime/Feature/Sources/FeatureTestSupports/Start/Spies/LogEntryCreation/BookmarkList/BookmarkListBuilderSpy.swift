//
//  File.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import Start
import RIBsTestSupport

public final class BookmarkListBuildableSpy : BookmarkListBuildable {
  
  public var buildHandler: ((_ listener: BookmarkListListener) -> BookmarkListRouting)?
  
  public func build(withListener listener: BookmarkListListener, payload: BookmarkListBuildDependency) -> BookmarkListRouting {
    
    if let buildHandler = buildHandler {
      return buildHandler(listener)
    }
    
    fatalError()
  }
  
  public init() {}
}
