//
//  File.swift
//  
//
//  Created by 이상헌 on 12/9/23.
//

import RxSwift
@testable import StartImpl

// MARK: - LogEntryCreationPresentableListenerStub

final class LogEntryCreationPresentableListenerStub: LogEntryCreationPresentableListener {
  func sendAction(_ action: Action) {
    
  }
  
  var state: Observable<State> = .just(.init())
  
  func didTapTagCell() {
    
  }
  
  func numberOfItems() -> Int {
    5
  }
  
  func bookmark(at index: Int) -> String {
    "Bookmark"
  }
  
  init() {}
}
