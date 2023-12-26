//
//  BookmarkEditorInteractor.swift
//  
//
//  Created by 이상헌 on 11/14/23.
//
import Foundation

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
  private let bookmarkModelDataStream: BookmarkModelDataStream
  
  // MARK: - Initialization & DeInitialization
  
  init(
    presenter: BookmarkEditorPresentable,
    bookmarkModelDataStream: BookmarkModelDataStream
  ) {
    self.bookmarkModelDataStream = bookmarkModelDataStream
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
    listener?.detachBookmarkEditorRIB()
  }
  
  func didTapTagCell(at index: IndexPath) {
    
  }
  
   // MARK: - Private
  
  private func presentError(error: Error) {
    
  }

}
