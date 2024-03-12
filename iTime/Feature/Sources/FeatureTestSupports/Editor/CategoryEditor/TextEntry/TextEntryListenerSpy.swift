//
//  File.swift
//  
//
//  Created by 이상헌 on 3/12/24.
//

import Editor

public class TextEntryListenerSpy: TextEntryListener {
  
  public var currentCategoryTitleCallCount: Int = 0
  public var passedTitle: String = String()
  public func currentCategoryTitle(with title: String) {
    currentCategoryTitleCallCount += 1
    passedTitle = title
  }
  
  public init() {}
}
