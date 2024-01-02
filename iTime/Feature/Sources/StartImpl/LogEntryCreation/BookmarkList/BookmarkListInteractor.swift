//
//  BookmarkListInteractor.swift
//
//
//  Created by 이상헌 on 12/10/23.
//
import Foundation

import RIBs
import RxSwift

import Entities
import Start
import AppFoundation

// MARK: - BookmarkListPresentable

public protocol BookmarkListPresentable: Presentable {
  var listener: BookmarkListPresentableListener? { get set }
  func presentError(_ error: DisplayErrorMessage)
  func hiddenEmptyIfNeeded(_ isHidden: Bool)
  func reloadBookmarks()
}

// MARK: - BookmarkListInteractor

final class BookmarkListInteractor:
  PresentableInteractor<BookmarkListPresentable>,
  BookmarkListInteractable,
  BookmarkListPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: BookmarkListRouting?
  weak var listener: BookmarkListListener?
  private let bookmarkModelDataStream: BookmarkModelDataStream
  private var state: BookmarkListModel.State
  
  // MARK: - Initialization & DeInitialization
  
  init(
    initialState: BookmarkListModel.State,
    presenter: BookmarkListPresentable,
    bookmarkModelDataStream: BookmarkModelDataStream
  ) {
    self.state = initialState
    self.bookmarkModelDataStream = bookmarkModelDataStream
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  deinit {
    print("deinit \(type(of: self))")
  }
  
  func loadBookmarkList() {
    bookmarkModelDataStream.bookmarks
      .catch ({ [weak self] error in
        guard let self else { return .empty() }
        self.presenter.presentError(self.bookmarkListErrorMessage(error.localizedDescription))
        return .empty()
      })
      .subscribe(with: self) { owner, bookmarks in
        var newState = owner.state
        newState.bookmarks = bookmarks
        owner.state = newState
        owner.presenter.reloadBookmarks()
        owner.presenter.hiddenEmptyIfNeeded(!bookmarks.isEmpty)
      }
      .disposeOnDeactivate(interactor: self)
  }
  
  func numberOfItems() -> Int {
    state.bookmarks.count
  }
  
  func bookmark(at index: Int) -> String {
    state.bookmarks[safe: index]?.title ?? ""
  }
  
  func didTapTagCell(at index: IndexPath) {
    guard let selectedBookmark = state.bookmarks[safe: index.row] else { return }
    listener?.didTapTagCell(selectedBookmark)
  }
  
  private func bookmarkListErrorMessage(_ message: String) -> DisplayErrorMessage {
    return DisplayErrorMessage(
      title: "Bookmark List Error",
      message: message,
      confirmActionTitle: "Confirm"
    )
  }
}

