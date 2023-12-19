//
//  File.swift
//  
//
//  Created by 이상헌 on 12/19/23.
//

import Entities

public struct CategotyLog {
  public let title: String
  public let color: String
  
  public init(title: String, color: String) {
    self.title = title
    self.color = color
  }
  
  public static let empty: Self = .init(title: String(), color: String())
}

extension Category {
  public static func toCategory(_ category: CategotyLog) -> Self {
    Category(
      title: category.title,
      color: category.color
    )
  }
}
