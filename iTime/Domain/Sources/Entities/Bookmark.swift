//
//  File.swift
//  
//
//  Created by 이상헌 on 12/1/23.
//


public struct Bookmark: Equatable {
  public let title: String
  public let category: Category
  
  public init(title: String, category: Category) {
    self.title = title
    self.category = category
  }
  
  public static func == (lhs: Bookmark, rhs: Bookmark) -> Bool {
    lhs.title == rhs.title
  }
}
