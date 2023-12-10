//
//  BookmarkListInteractor.swift
//  
//
//  Created by 이상헌 on 12/10/23.
//

import RIBs
import RxSwift

import Start

// MARK: - BookmarkListPresentable

protocol BookmarkListPresentable: Presentable {
  var listener: BookmarkListPresentableListener? { get set }
}

// MARK: - BookmarkListInteractor

final class BookmarkListInteractor: 
  PresentableInteractor<BookmarkListPresentable>,
  BookmarkListInteractable,
  BookmarkListPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: BookmarkListRouting?
  weak var listener: BookmarkListListener?
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: BookmarkListPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  func didTapBookmarkTagEditor() {
    
  }
  
  func numberOfItems() -> Int {
    2
  }
  
  func bookmark(at index: Int) -> String {
    "22"
  }
  
  func didTapTagCell() {
    print()
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
}
