//
//  File.swift
//  
//
//  Created by 이상헌 on 11/24/23.
//

import SharedUI
import BookmarkUsecase

// MARK: - SavedItemSectionListener

protocol SavedItemSectionListener: AnyObject {
  func didTapSaveItemSectionCell()
  func numberOfSavedItems() -> Int
  func configurationSavedItem() -> String
}

// MARK: - SavedItemSectionDelegateDatasoruce

final class SavedItemSectionDelegateDataSource:
  BookmarkTagsCollectionViewAdapterDataSource,
  BookmarkCollectionViewCellDelegate
{
  
  weak var listener: SavedItemSectionListener?
  
  func numberOfItems() -> Int {
    guard let listener = listener else { return  -1 }
    return listener.numberOfSavedItems()
  }
  
  func configurationData(at index: Int) -> String {
    guard let listener = listener else { return String() }
    return listener.configurationSavedItem()
  }
  
  func didTapTagCell() {
    guard let listener = listener else { return }
    listener.didTapSaveItemSectionCell()
  }
}
