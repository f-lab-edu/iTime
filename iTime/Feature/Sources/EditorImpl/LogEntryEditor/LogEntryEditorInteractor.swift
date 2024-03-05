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
  private(set) var state: LogEntryEditorState
  
  // MARK: - Initialization & DeInitialization
  
  init(
    initialState: LogEntryEditorState,
    presenter: LogEntryEditorPresentable,
    activityLogModelStream: ActivityLogModelStream
  ) {
    self.state = initialState
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
    router?.attachCategoryEditorRIB(with: state.category)
  }
  
  func didTapCloseButton() {
    listener?.detachLogEntryEditorRIB()
  }
  
  func detachCategoryEditorRIB() {
    router?.detachCategoryEditorRIB()
  }
}
