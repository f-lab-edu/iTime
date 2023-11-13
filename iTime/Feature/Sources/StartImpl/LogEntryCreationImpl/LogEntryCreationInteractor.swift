//
//  LogEntryCreationInteractor.swift
//
//
//  Created by 이상헌 on 2023/11/05.
//

import RIBs
import RxSwift

import Start

protocol LogEntryCreationPresentable: Presentable {
  var listener: LogEntryCreationPresentableListener? { get set }
}

final class LogEntryCreationInteractor:
  PresentableInteractor<LogEntryCreationPresentable>,
  LogEntryCreationInteractable,
  LogEntryCreationPresentableListener
{
  
  func didTap() {
    
  }
  
  var numberOfItems: Int { 10 }
  
  func fetchData(at index: Int) -> String {
    "진짜"
  }
  
  weak var router: LogEntryCreationRouting?
  weak var listener: LogEntryCreationListener?
  
  override init(presenter: LogEntryCreationPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
  
  override func willResignActive() {
    super.willResignActive()
  }
}
