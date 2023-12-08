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
  LogEntryCreationPresentableListener,
  LightReactor
{
  
  // MARK: - LightReactor
  
  typealias Action = LogEntryCreationPresentableAction
  typealias State = LogEntryCreationPresentableState
  
  enum Mutation {
    case setBookmarks([Bookmark])
    case setIsHiddenEncouragingBox(Bool)
    case attachBookmarkEditorRIB
    case attachLogEntryEditorRIB
    case attachTimeLogRunningRIB
  }
  
  weak var router: LogEntryCreationRouting?
  weak var listener: LogEntryCreationListener?
  let initalState: LogEntryCreationPresentableState
  
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
  
}

// MARK: - Mutate

extension LogEntryCreationInteractor {
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .loadData:
      return loadDataMutation()
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
  
  private func loadDataMutation() -> Observable<Mutation> {
    let loadDataMutation: Observable<Mutation> = bookmarkModelDataStream.bookmarks
      .map(Mutation.setBookmarks)
      .catchAndReturn(.setBookmarks([])) // TODO: revision -> Pursue로 바꿔보기 error mesage change 필요
    
    return loadDataMutation
  }
  
  private func didTapEncouragingBoxMutation() -> Observable<Mutation> {
    return .empty()
  }
  
  private func didTapSettingButtonMutation() -> Observable<Mutation> {
    return .empty()
  }
  
  private func didTapBookmarkTagEditorMutation() -> Observable<Mutation> {
    return .just(.attachBookmarkEditorRIB)
  }
  
  private func didTapEditorRoutingButtonMutation() -> Observable<Mutation> {
    return .just(.attachLogEntryEditorRIB)
  }
  
  private func didTapStartButtonMutation() -> Observable<Mutation> {
    return .just(.attachTimeLogRunningRIB)
  }
  
  private func didTapTagCellMutation() -> Observable<Mutation> {
    return .empty()
  }
  
  private func didTapEncouragingBoxCloseButtonMutation() -> Observable<Mutation> {
    return .just(.setIsHiddenEncouragingBox(true))
  }
}

// MARK: - Transform

extension LogEntryCreationInteractor {
  func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
    mutation
      .withUnretained(self)
      .flatMap { owner, mutation -> Observable<Mutation> in
        switch mutation {
        case .attachBookmarkEditorRIB:
          return owner.attachBookmarkEditorRIBTransform()
        case .attachLogEntryEditorRIB:
          return owner.attachLogEntryEditorRIBTransform()
        case .attachTimeLogRunningRIB:
          return owner.attachTimeLogRunnningRIBTransform()
        default:
          return .just(mutation)
        }
      }
  }
  
  private func attachBookmarkEditorRIBTransform() -> Observable<Mutation> {
    router?.attachBookmarkEditorRIB()
    return .empty()
  }
  
  private func attachLogEntryEditorRIBTransform() -> Observable<Mutation> {
    router?.attachLogEntryEditorRIB()
    return .empty()
  }
  
  private func attachTimeLogRunnningRIBTransform() -> Observable<Mutation> {
    router?.attachTimeLogRunningRIB()
    return .empty()
  }
}

// MARK: - Reduce

extension LogEntryCreationInteractor {
  func reduce(state: State, mutation: Mutation) -> LogEntryCreationPresentableState {
    var newState = state
    
    switch mutation {
    case let .setBookmarks(bookmarks):
      newState.bookmarks = bookmarks
    case let .setIsHiddenEncouragingBox(isHidden):
      newState.isHiddenEncouragingBox = isHidden
    default:
      print("mutation \(mutation)")
    }
    
    return newState
  }
}

// MARK: - Delegate & DataSource

extension LogEntryCreationInteractor {
  func numberOfItems() -> Int {
    currentState.bookmarks.count
  }
  
  func bookmark(at index: Int) -> String {
    currentState.bookmarks[safe: index]?.title ?? ""
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
