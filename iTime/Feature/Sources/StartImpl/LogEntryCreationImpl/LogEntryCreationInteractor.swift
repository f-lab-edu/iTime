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
import AppFoundation

// MARK: - LogEntryCreationPresentable

protocol LogEntryCreationPresentable: Presentable {
  var listener: LogEntryCreationPresentableListener? { get set }
}

// MARK: - LogEntryCreationInteractor

final class LogEntryCreationInteractor:
  PresentableInteractor<LogEntryCreationPresentable>,
  LogEntryCreationInteractable,
  LogEntryCreationPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: LogEntryCreationRouting?
  weak var listener: LogEntryCreationListener?
  
  private let bookmarkModelDataStream: BookmarkModelDataStream
  
  // MARK: Initialziation
  
  init(
    presenter: LogEntryCreationPresentable,
    bookmarkModelDataStream: BookmarkModelDataStream
  ) {
    self.bookmarkModelDataStream = bookmarkModelDataStream
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  func didTapEncouragingBox() {
    
  }
  
  func didTapSettingButton() {
    
  }
  
  func didTapEditorRoutingButton() {
    router?.attachLogEntryEditorRIB()
  }
  
  func didTapStartButton() {
    router?.attachTimeLogRunningRIB()
  }
  
  func didTapBookmarkTagEditor() {
    router?.attachBookmarkEditorRIB()
  }
  
}

// MARK: - Listener

extension LogEntryCreationInteractor {
  func detachLogEntryEditorRIB() {
    router?.detachLogEntryEditorRIB()
  }
  
  func detachBookmarkEditorRIB() {
    router?.detachBookmarkEditorRIB()
  }
  
  func attachTimeLogRunningRIB() {
    router?.attachTimeLogRunningRIB()
  }
  
  func detachTimeLogRunningRIB() {
    router?.detachTimeLogRunningRIB()
  }
  
  func didTapTagCell() {
    print("didTapTagCell")
  }
  
}
