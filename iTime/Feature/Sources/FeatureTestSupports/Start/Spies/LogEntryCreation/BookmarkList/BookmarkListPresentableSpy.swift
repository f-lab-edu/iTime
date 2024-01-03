//
//  File.swift
//
//
//  Created by 이상헌 on 1/2/24.
//

import Foundation
import AppFoundation
import StartImpl

public final class BookmarkListPresentableSpy: BookmarkListPresentable {
  
  public private(set) var listenerSetCallCount = 0
  public var listener: BookmarkListPresentableListener? { didSet { self.listenerSetCallCount += 1 }}
  
  public var presentErrorCallCount: Int = 0
  public func presentError(_ error: DisplayErrorMessage) {
    presentErrorCallCount += 1
  }
  
  public var hiddenEmptyIfNeededCallCount: Int = 0
  public var isHiddenProperty: Bool = false
  public func hiddenEmptyIfNeeded(_ isHidden: Bool) {
    isHiddenProperty = isHidden
    hiddenEmptyIfNeededCallCount += 1
  }
  
  public var reloadBookmarksCallCount: Int = 0
  public func reloadBookmarks() {
    reloadBookmarksCallCount += 1
  }
  
  public init() {}
}
