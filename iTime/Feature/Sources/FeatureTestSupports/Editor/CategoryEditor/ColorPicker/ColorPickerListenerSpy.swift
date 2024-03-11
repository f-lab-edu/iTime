//
//  File.swift
//  
//
//  Created by 이상헌 on 3/11/24.
//

import Foundation
import Editor

public class ColorPickerListenerSpy: ColorPickerListener {
  
  public var passedHex: String = String()
  public var currentCategoryColorHexCallCount: Int = 0
  public func currentCategoryColorHex(with hex: String) {
    currentCategoryColorHexCallCount += 1
    passedHex = hex
  }
  
  public init() {}
}
