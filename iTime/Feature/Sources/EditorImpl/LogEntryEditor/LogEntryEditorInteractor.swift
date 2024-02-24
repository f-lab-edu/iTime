//
//  LogEntryEditorInteractor.swift
//  
//
//  Created by 이상헌 on 11/13/23.
//

import Foundation

import RIBs
import RxSwift

import Editor
import Start

// MARK: - LogEntryEditorPresentable

protocol LogEntryEditorPresentable: Presentable {
  var listener: LogEntryEditorPresentableListener? { get set }
}

// MARK: - LogEntryEditorInteractor

final class LogEntryEditorInteractor: 
  PresentableInteractor<LogEntryEditorPresentable>,
  LogEntryEditorInteractable,
  LogEntryEditorPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: LogEntryEditorRouting?
  weak var listener: LogEntryEditorListener?
  
  private let activityLogModelStream: ActivityLogModelStream
  
  // MARK: - Initialization & DeInitialization
  
  init(
    presenter: LogEntryEditorPresentable,
    activityLogModelStream: ActivityLogModelStream
  ) {
    self.activityLogModelStream = activityLogModelStream
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  func didTapStartButton(_ title: String?) {
    activityLogModelStream.updateActivityTitle(with: title ?? "")
    listener?.attachTimeLogRunningRIB()
    listener?.detachLogEntryEditorRIB()
  }

  func didTapCategoryStateView() {
    router?.attachCategoryEditorRIB()
  }
  
  func didTapCloseButton() {
    listener?.detachLogEntryEditorRIB()
  }
  
  func detachCategoryEditorRIB() {
    router?.detachCategoryEditorRIB()
  }
}
