//
//  File.swift
//  
//
//  Created by 이상헌 on 11/19/23.
//

import Editor
import RIBsTestSupport

// MARK: - BookmarkEditorBuildableMock

public final class BookmarkEditorBuildableSpy: BookmarkEditorBuildable {
  
  public var buildHandler: ((_ listener: BookmarkEditorListener) -> BookmarkEditorRouting)?
  
  public var buildCallCount = 0
  public func build(withListener listener: BookmarkEditorListener) -> BookmarkEditorRouting {
    buildCallCount += 1
    
    if let buildHandler = buildHandler {
      return buildHandler(listener)
    }
    
    fatalError()
  }
  
  public init() {}
}

// MARK: - BookmarkEditorRoutingMock

public final class BookmarkEditorRoutingMock:
  ViewableRoutingMock,
  BookmarkEditorRouting {
  
  public var detachBookmarkEditorRIBCallCount: Int = 0
  public func detachBookmarkEdtiorRIB() {
    detachBookmarkEditorRIBCallCount += 1
  }
}


