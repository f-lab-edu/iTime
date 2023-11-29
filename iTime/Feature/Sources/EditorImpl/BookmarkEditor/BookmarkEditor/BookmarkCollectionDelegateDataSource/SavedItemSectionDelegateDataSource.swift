//
//  File.swift
//  
//
//  Created by 이상헌 on 11/24/23.
//

import SharedUI
import Usecase

// MARK: - SavedItemSectionListener

protocol SavedItemSectionDelegateDataSource: AnyObject {
  func didTapSaveItemSectionCell()
  func numberOfSavedItems() -> Int
  func configurationSavedItem(at index: Int) -> String
}
