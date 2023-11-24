//
//  File.swift
//  
//
//  Created by 이상헌 on 11/24/23.
//

import SharedUI
import BookmarkUsecase

// MARK: - SavedItemSectionListener

protocol ItemHistorySectionListener: AnyObject {
  func didTapItemHistorySectionCell()
  func numberOfHistoryItems() -> Int
  func configurationHistoryItem() -> String
}

final class ItemHistorySectionDelegateDataSource:
  BookmarkTagsCollectionViewAdapterDataSource,
  BookmarkCollectionViewCellDelegate
{
  
  weak var listener: ItemHistorySectionListener?
  
  func numberOfItems() -> Int {
    guard let listener = listener else { return  -1 }
    return listener.numberOfHistoryItems()
  }
  
  func configurationData(at index: Int) -> String {
    guard let listener = listener else { return String() }
    return listener.configurationHistoryItem()
  }
  
  func didTapTagCell() {
    guard let listener = listener else { return }
    listener.didTapItemHistorySectionCell()
  }
  
}
