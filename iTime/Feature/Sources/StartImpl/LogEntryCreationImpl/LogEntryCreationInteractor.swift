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
  
  weak var router: LogEntryCreationRouting?
  weak var listener: LogEntryCreationListener?
  
  private let bookmarkModelDataStream: BookmarkModelDataStream
  
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
  
}

// MARK: - Listener

extension LogEntryCreationInteractor {
  func detachLocationEntryEditorRIB() {
    print("detachLocationEntryEditorRIB")
  }
  
  func attachTimeLogRunningRIB() {
    print("attachTimeLogRunningRIB")
  }
}
