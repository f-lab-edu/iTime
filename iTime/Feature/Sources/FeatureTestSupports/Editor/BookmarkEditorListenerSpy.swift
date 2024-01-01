//
//  File.swift
//  
//
//  Created by 이상헌 on 1/1/24.
//

import Editor

public class BookmarkEditorListenerSpy: BookmarkEditorListener {
  
  public var detachBookmarkEditorRIBCallCount: Int = 0
  public func detachBookmarkEditorRIB() {
    detachBookmarkEditorRIBCallCount += 1
  }
  
  public init() {}
}
