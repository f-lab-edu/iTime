//
//  File.swift
//  
//
//  Created by 이상헌 on 11/24/23.
//

import SharedUI
import BookmarkUsecase

// MARK: - SavedItemSectionListener

protocol ItemHistorySectionDelegateDataSource: AnyObject {
  func didTapItemHistorySectionCell()
  func numberOfHistoryItems() -> Int
  func configurationHistoryItem(at index: Int) -> String
}
