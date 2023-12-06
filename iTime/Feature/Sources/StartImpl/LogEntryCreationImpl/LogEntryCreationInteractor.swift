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

protocol LogEntryCreationPresentable: Presentable {
  var listener: LogEntryCreationPresentableListener? { get set }
}

final class LogEntryCreationInteractor:
  PresentableInteractor<LogEntryCreationPresentable>,
  LogEntryCreationInteractable,
  LogEntryCreationPresentableListener,
  LightReactor
{
  
  // MARK: - LightReactor
  
  typealias Action = LogEntryCreationPresentableAction
  typealias State = LogEntryCreationPresentableState
  
  enum Mutation {
    case setLoading(Bool)
  }
  
  weak var router: LogEntryCreationRouting?
  weak var listener: LogEntryCreationListener?
  let initalState: LogEntryCreationPresentableState
  
  private var bookmarks: [Bookmark] = []
  
  private let bookmarkModelDataStream: BookmarkModelDataStream
  
  init(
    initialState: LogEntryCreationPresentableState,
    presenter: LogEntryCreationPresentable,
    bookmarkModelDataStream: BookmarkModelDataStream
  ) {
    self.initalState = initialState
    self.bookmarkModelDataStream = bookmarkModelDataStream
    super.init(presenter: presenter)
    presenter.listener = self
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

}

// MARK: - Mutate
extension LogEntryCreationInteractor {
    func mutate(action: LogEntryCreationPresentableAction) -> Observable<Mutation> {
        switch action {
        case .didTapEncouragingBox: 
            return didTapEncouragingBoxMutation()
        case .didTapSettingButton:
            return didTapSettingButtonMutation()
        case .didTapBookmarkTagEditor:
            return didTapBookmarkTagEditorMutation()
        case .didTapEditorRoutingButton:
            return didTapEditorRoutingButtonMutation()
        case .didTapStartButton:
            return didTapStartButtonMutation()
        case .didTapTagCell:
            return didTapTagCellMutation()
        case .didTapEncouragingBoxCloseButton:
            return didTapEncouragingBoxCloseButtonMutation()
        }
    }
    
    private func didTapEncouragingBoxMutation() -> Observable<Mutation> {
        return .empty()
    }
    
    private func didTapSettingButtonMutation() -> Observable<Mutation> {
        return .empty()
    }
    
    private func didTapBookmarkTagEditorMutation() -> Observable<Mutation> {
        router?.attachBookmarkEditorRIB()
        return .empty()
    }
    
    private func didTapEditorRoutingButtonMutation() -> Observable<Mutation> {
        router?.attachLogEntryEditorRIB(
        return .empty()
    }
    
    private func didTapStartButtonMutation() -> Observable<Mutation> {
        router?.attachTimeLogRunningRIB()
        return .empty()
    }
    
    private func didTapTagCellMutation() -> Observable<Mutation> {
        return .empty()
    }
    
    private func didTapEncouragingBoxCloseButtonMutation() -> Observable<Mutation> {
        return .empty()
    }
}

// MARK: - Reduce

extension LogEntryCreationInteractor {
    func reduce(state: LogEntryCreationPresentableState, mutation: Mutation) -> LogEntryCreationPresentableState {
        return .init()
    }
}

// MARK: - Delegate & DataSource

extension LogEntryCreationInteractor {
    func numberOfItems() -> Int {
      bookmarks.count
    }
    
    func bookmark(at index: Int) -> String {
      "Bookmark"
    }
    
    func didTapTagCell() {
        sendAction(.didTapTagCell)
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
