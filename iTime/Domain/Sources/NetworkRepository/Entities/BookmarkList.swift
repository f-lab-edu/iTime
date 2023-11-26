//
//  File.swift
//  
//
//  Created by 이상헌 on 11/26/23.
//

import Foundation

// MARK: - BookmarkList

public struct BookmarkList: Codable {
  public let bookmarks: [Activity]
  
  public init(_ bookmarks: [Activity]) {
    self.bookmarks = bookmarks
  }
}
