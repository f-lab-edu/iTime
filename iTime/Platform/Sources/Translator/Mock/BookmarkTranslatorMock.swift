//
//  File.swift
//  
//
//  Created by 이상헌 on 12/1/23.
//

import Models
import Entities

public class BookmarkTranslatorMock: BookmarkTranslator {
  public func translateToBookmarks(by performs: [Perform]) -> [Bookmark] {
    []
  }
  
  public func translateToPerformList(by bookmarks: [Bookmark]) -> PerformList {
    .init([])
  }
  
  public init () {}
}
