//
//  File.swift
//  
//
//  Created by 이상헌 on 3/12/24.
//

import EditorImpl

public class TextEntryPresenterSpy: TextEntryPresentable {
  public var listener: EditorImpl.TextEntryPresentableListener?
  
  public var updateCategoryTextFieldPassedText: String = String()
  public var updateCategoryTextFieldCallCount: Int = 0
  public func updateCategoryTextField(with text: String) {
    updateCategoryTextFieldCallCount += 1
    updateCategoryTextFieldPassedText = text
  }
  
  public init() {}
}
