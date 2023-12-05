//
//  BookmarkEditorInteractor.swift
//  
//
//  Created by 이상헌 on 11/14/23.
//

import RIBs
import RxSwift

import Editor
import Usecase
import Entities

// MARK: - BookmarkEditorPresentable

protocol BookmarkEditorPresentable: Presentable {
  var listener: BookmarkEditorPresentableListener? { get set }
}

// MARK: - BookmarkEditorInteractor

final class BookmarkEditorInteractor: 
  PresentableInteractor<BookmarkEditorPresentable>,
  BookmarkEditorInteractable,
  BookmarkEditorPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: BookmarkEditorRouting?
  weak var listener: BookmarkEditorListener?
  private let mutableBookmarkModelDataStream: MutableBookmarkModelDataStream
  
  // MARK: - Initialization & DeInitialization
  
  init(
    presenter: BookmarkEditorPresentable,
    mutableBookmarkModelDataStream: MutableBookmarkModelDataStream
  ) {
    self.mutableBookmarkModelDataStream = mutableBookmarkModelDataStream
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
  
  // MARK: - Mutation
  
  func didTapSaveButton() {
      
  }
  
  func didTapAddButton() {
   
  }
  
  func didTapBackButton() {
   
  }
  
   // MARK: - Private
  
  private func presentError(error: Error) {
    
  }

}

// MARK: - SavedItemSection

extension BookmarkEditorInteractor {
  func numberOfSavedItems() -> Int {
    3
  }
  
  func configurationSavedItem(at index: Int) -> String {
    "SavedItem"
  }
  
  func didTapSaveItemSectionCell() {
    print("didTapSaveItemSectionCell")
  }
}

// MARK: - ItemHistorySection

extension BookmarkEditorInteractor {
  
  func numberOfHistoryItems() -> Int {
    3
  }
  
  func configurationHistoryItem(at index: Int) -> String {
    "HistoryItem"
  }
  
  func didTapItemHistorySectionCell() {
    print("didTapItemHistorySectionCell")
  }
}
