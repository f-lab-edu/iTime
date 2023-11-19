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
    
  weak var router: LogEntryCreationRouting?
  weak var listener: LogEntryCreationListener?
  
  override init(presenter: LogEntryCreationPresentable) {
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
    
  }
  
  func didTapEditorRoutingButton() {
    
  }
  
  func didTapStartButton() {
    
  }
  
  func didTapTagCell() {
    
  }
  
  // BookmarkTagCoollectionView DataSources
  // TODO: init data
  func numberOfItems() -> Int {
    10
  }
  
  func configurationData(at index: Int) -> String {
   ""
  }
}

