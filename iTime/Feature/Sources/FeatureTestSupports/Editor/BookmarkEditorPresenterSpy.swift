//
//  File.swift
//  
//
//  Created by 이상헌 on 1/1/24.
//

import EditorImpl
import AppFoundation

public class BookmarkEditorPresenterSpy: BookmarkEditorPresentable {
  public private(set) var listenerSetCallCount: Int = 0
  public var listener: BookmarkEditorPresentableListener? { didSet { self.listenerSetCallCount += 1 }}
  
  public private(set) var presentErrorCallCount: Int = 0
  public func presentError(_ error: DisplayErrorMessage) {
    presentErrorCallCount += 1
  }
  
  public init() {}
}
