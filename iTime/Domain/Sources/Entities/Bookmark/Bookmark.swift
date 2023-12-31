//
//  File.swift
//  
//
//  Created by 이상헌 on 11/19/23.
//

import Foundation

// MARK: - Bookmark

public struct Bookmark {
  public let title: String
  public let category: Category
  
  public init(title: String, category: Category) {
    self.title = title
    self.category = category
  }
  
  public init(_ activity: Activity) {
    self.title = activity.title
    self.category = activity.category
  }
  
  public static let empty: Self = .init(title: String(), category: .empty)
}

// MARK: - Equatable

extension Bookmark: Equatable {
  public static func == (lhs: Bookmark, rhs: Bookmark) -> Bool {
    return lhs.title.replacingOccurrences(of: " ", with: "") == rhs.title.replacingOccurrences(of: " ", with: "")
  }
}
