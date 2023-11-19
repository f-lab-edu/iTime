//
//  File.swift
//  
//
//  Created by 이상헌 on 11/19/23.
//

import Start
import RIBsTestSupport

// MARK: - BookmarkEditorBuildableMock

final class BookmarkEditorBuildableMock: BookmarkEditorBuildable {
  
  var buildHandler: ((_ listener: BookmarkEditorListener) -> BookmarkEditorRouting)?
  
  
  var buildCallCount = 0
  func build(withListener listener: BookmarkEditorListener) -> BookmarkEditorRouting {
    buildCallCount += 1
    
    if let buildHandler = buildHandler {
      return buildHandler(listener)
    }
    
    fatalError()
  }
}

// MARK: - BookmarkEditorRoutingMock

final class BookmarkEditorRoutingMock: ViewableRoutingMock, BookmarkEditorRouting {
}
