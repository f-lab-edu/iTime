//
//  File.swift
//  
//
//  Created by 이상헌 on 1/17/24.
//

import UIKit

struct CategoryColors: OptionSet {
  
  let rawValue: Int
  
  static let gray         = CategoryColors(rawValue:  1 << 0)
  static let red          = CategoryColors(rawValue:  1 << 1)
  static let yellow       = CategoryColors(rawValue:  1 << 2)
  static let green        = CategoryColors(rawValue:  1 << 3)
  static let greenblue    = CategoryColors(rawValue:  1 << 4)
  static let blue         = CategoryColors(rawValue:  1 << 5)
  static let pulple       = CategoryColors(rawValue:  1 << 6)
  static let greenpulple  = CategoryColors(rawValue:  1 << 7)
  static let unknown      = CategoryColors(rawValue: .zero)
  
  static let all: CategoryColors = [ .gray, .red, .yellow, .green, .greenblue, .blue, .pulple, .greenpulple ]
}
