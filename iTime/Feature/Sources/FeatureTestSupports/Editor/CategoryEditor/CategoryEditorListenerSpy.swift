//
//  File.swift
//  
//
//  Created by 이상헌 on 2/25/24.
//

import Editor

public final class CategoryEditorListenerSpy: CategoryEditorListener {
  public var detachCategoryEditorRIBCallCount: Int = 0
  public func detachCategoryEditorRIB() {
    detachCategoryEditorRIBCallCount += 1
  }
  
  public init() {}
}
