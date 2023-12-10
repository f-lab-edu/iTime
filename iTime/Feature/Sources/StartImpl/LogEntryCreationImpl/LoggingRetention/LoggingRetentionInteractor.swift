//
//  LoggingRetentionInteractor.swift
//  
//
//  Created by 이상헌 on 12/10/23.
//

import RIBs
import RxSwift

import LoggingRetention

// MARK: - LoggingRetentionPresentable

protocol LoggingRetentionPresentable: Presentable {
  var listener: LoggingRetentionPresentableListener? { get set }
}

// MARK: - LoggingRetentionInteractor

final class LoggingRetentionInteractor: 
  PresentableInteractor<LoggingRetentionPresentable>,
  LoggingRetentionInteractable,
  LoggingRetentionPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: LoggingRetentionRouting?
  weak var listener: LoggingRetentionListener?
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: LoggingRetentionPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
}
