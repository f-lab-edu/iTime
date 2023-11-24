//
//  File.swift
//  
//
//  Created by 이상헌 on 11/19/23.
//

import Foundation

// MARK: - Bookmark

public struct Bookmark: Codable, Equatable {
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

// MARK: - BookmarkList

public struct BookmarkList: Codable {
  public let bookmarks: [Bookmark]
  
  public init(_ bookmarks: [Bookmark]) {
    self.bookmarks = bookmarks
  }
}
