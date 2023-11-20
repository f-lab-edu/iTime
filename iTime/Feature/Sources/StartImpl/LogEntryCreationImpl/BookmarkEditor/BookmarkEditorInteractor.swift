//
//  BookmarkEditorInteractor.swift
//  
//
//  Created by 이상헌 on 11/14/23.
//

import RIBs
import RxSwift

import Start

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
  
  // TODO: Init Data
  func numberOfItems() -> Int {
    6
  }
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: BookmarkEditorPresentable) {
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
  
  func configurationData(at index: Int) -> String {
    "222"
  }
  
  func didTapTagCell() {
    
  }
}
