//
//  File.swift
//  
//
//  Created by 이상헌 on 11/26/23.
//

import Foundation

// MARK: - Activity

public struct Activity: Codable {
  public let title: String
  public let category: Category
  
  public init(title: String, category: Category) {
    self.title = title
    self.category = category
  }
  
  public static func == (lhs: Activity, rhs: Activity) -> Bool {
    lhs.title == rhs.title
  }
}

