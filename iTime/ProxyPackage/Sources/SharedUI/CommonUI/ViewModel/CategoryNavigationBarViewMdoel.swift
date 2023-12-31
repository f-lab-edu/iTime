//
//  File.swift
//  
//
//  Created by 이상헌 on 12/28/23.
//

import Foundation

public struct CategoryNavigationBarViewMdoel {
  let categoryViewModel: CategoryViewModel
  let isHiddenRightItem: Bool
  
  public init(categoryViewModel: CategoryViewModel, isHiddenRightItem: Bool) {
    self.categoryViewModel = categoryViewModel
    self.isHiddenRightItem = isHiddenRightItem
  }
}
