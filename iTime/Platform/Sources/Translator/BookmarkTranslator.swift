//
//  File.swift
//  
//
//  Created by 이상헌 on 12/1/23.
//

import Models
import Entities

// MARK: - BookmarkTranslator

public final class BookmarkTranslator {
  public func translateToBookmarks(by performs: [Perform]) -> [Bookmark] {
    performs.map {
      Bookmark(
        title: $0.title,
        category: Category(
          title: $0.classification.title,
          color: $0.classification.color
        )
      )
    }
  }
  
  public func translateToPerformList(by bookmarks: [Bookmark]) -> PerformList {
    .init(
      bookmarks.map {
        Perform(
          title: $0.title,
          classification: Classification(
            title: $0.category.title,
            color: $0.category.color
          )
        )
      }
    )
  }
  public init() {}
}
