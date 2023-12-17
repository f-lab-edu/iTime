//
//  File.swift
//  
//
//  Created by 이상헌 on 12/16/23.
//

import Entities
import AppFoundation

enum BookmarkListModel {
  enum ViewModel {
    case errorAlert(DisplayErrorMessage)
  }
  struct State {
    var bookmarks: [Bookmark] = []
  }
}
