//
//  File.swift
//  
//
//  Created by 이상헌 on 12/1/23.
//

public struct Activity: Equatable {
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

extension Activity {
  public static let empty: Activity = .init(
    title: String(),
    category: .empty
  )
}
