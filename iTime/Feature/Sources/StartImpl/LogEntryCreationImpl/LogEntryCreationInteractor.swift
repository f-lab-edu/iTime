//
//  LogEntryCreationInteractor.swift
//
//
//  Created by 이상헌 on 2023/11/05.
//
import Foundation

import RIBs
import RxSwift

import Start
import Entities

protocol LogEntryCreationPresentable: Presentable {
  var listener: LogEntryCreationPresentableListener? { get set }
}

final class LogEntryCreationInteractor:
  PresentableInteractor<LogEntryCreationPresentable>,
  LogEntryCreationInteractable,
  LogEntryCreationPresentableListener
{
  
  weak var router: LogEntryCreationRouting?
  weak var listener: LogEntryCreationListener?
  private var bookmarks: [Bookmark] {
    return []
  }
  
  private let bookmarkModelDataStream: BookmarkModelDataStream
  
  init(
    presenter: LogEntryCreationPresentable,
    bookmarkModelDataStream: BookmarkModelDataStream
  ) {
    self.bookmarkModelDataStream = bookmarkModelDataStream
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
  
  // MARK: - Mutation
  
  func didTapEncouragingBox() {
    
  }
  
  func didTapSettingButton() {
      
  }
  
  func didTapBookmarkTagEditor() {
    router?.attachBookmarkEditorRIB()
  }
  
  func didTapEditorRoutingButton() {
    router?.attachLogEntryEditorRIB()
  }
  
  func didTapStartButton() {
    router?.attachTimeLogRunningRIB()
  }
  
  func didTapTagCell() {
    
  }
  
  func numberOfItems() -> Int {
    bookmarks.count
  }
  
  func bookmark(at index: Int) -> String {
    "Bookmark"
  }
  
  // MARK: - listener
  
  func detachLocationEntryEditorRIB() {
    print("detachLocationEntryEditorRIB")
  }
  
  func attachTimeLogRunningRIB() {
    print("attachTimeLogRunningRIB")
  }
}

