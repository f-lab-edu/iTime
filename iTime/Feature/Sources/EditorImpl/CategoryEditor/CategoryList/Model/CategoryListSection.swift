//
//  File.swift
//  
//
//  Created by 이상헌 on 1/5/24.
//

import Foundation
import SharedUI

enum CategoryListSection {
  case category(_ items: [Item])
  
  enum Item {
    case list(CategoryViewModel)
  }
  
  var items: [Item] {
    switch self {
    case let .category(items):
      return items
    }
  }
}
