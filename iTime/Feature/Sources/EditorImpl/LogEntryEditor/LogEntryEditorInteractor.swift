//
//  LogEntryEditorInteractor.swift
//  
//
//  Created by 이상헌 on 11/13/23.
//

import RIBs
import RxSwift

import Editor

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
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: LogEntryEditorPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
  
  // MARK: - Mutation
  
  func didTapStartButton() {
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
    listener?.detachLogEntryEditorRIB()
  }
}
