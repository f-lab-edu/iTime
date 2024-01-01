//
//  ActivityHistoryInteractor.swift
//
//
//  Created by 이상헌 on 12/10/23.
//
import Foundation

import RIBs
import RxSwift

import Entities
import Editor
import AppFoundation

// MARK: - ActivityHistoryPresentable

protocol ActivityHistoryPresentable: Presentable {
  var listener: ActivityHistoryPresentableListener? { get set }
  func presentError(_ error: DisplayErrorMessage)
  func hiddenEmptyIfNeeded(_ isHidden: Bool)
  func reloadActivities()
}

// MARK: - ActivityHistoryInteractor

final class ActivityHistoryInteractor:
  PresentableInteractor<ActivityHistoryPresentable>,
  ActivityHistoryInteractable,
  ActivityHistoryPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: ActivityHistoryRouting?
  weak var listener: ActivityHistoryListener?
  private let timeLogRecordModelDataStream: TimeLogRecordModelDataStream
  private let bookmarkModelDataStream: BookmarkModelDataStream
  private var state: ActivityHistoryModel.State
  
  // MARK: - Initialization & DeInitialization
  
  init(
    initialState: ActivityHistoryModel.State,
    presenter: ActivityHistoryPresentable,
    timeLogRecordModelDataStream: TimeLogRecordModelDataStream,
    bookmarkModelDataStream: BookmarkModelDataStream
  ) {
    self.state = initialState
    self.timeLogRecordModelDataStream = timeLogRecordModelDataStream
    self.bookmarkModelDataStream = bookmarkModelDataStream
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  deinit{
    print("deinit \(type(of: self))")
  }
  
  func loadActivityList() {
    Observable.combineLatest(
      timeLogRecordModelDataStream.timeLogRecords.map { $0.map(\.activity) },
      bookmarkModelDataStream.bookmarks
    )
    .catch ({ [weak self] error in
      guard let self else { return .empty() }
      self.presenter.presentError(self.activityListErrorMessage(error.localizedDescription))
      return .empty()
    })
    .map(filterSolidActivitiyList)
    .subscribe(with: self) { owner, activities in
      var newState = owner.state
      newState.activityList = activities
      owner.state = newState
      owner.presenter.reloadActivities()
      owner.presenter.hiddenEmptyIfNeeded(!activities.isEmpty)
    }
    .disposeOnDeactivate(interactor: self)
  }
  
  func numberOfItems() -> Int {
    state.activityList.count
  }
  
  func bookmark(at index: Int) -> String {
    state.activityList[safe: index]?.title ?? ""
  }
  
  func didTapTagCell(at index: IndexPath) {
    guard let selectedActivity = state.activityList[safe: index.row] else { return }
    bookmarkModelDataStream.append(Bookmark(selectedActivity))
  }
  
  private func activityListErrorMessage(_ message: String) -> DisplayErrorMessage {
    return DisplayErrorMessage(
      title: "Acitivity List Error",
      message: message,
      confirmActionTitle: "Confirm"
    )
  }
  
  private func filterSolidActivitiyList(_ activityList: [Activity], _ bookmarkList: [Bookmark]) -> [Activity] {
    activityList
      .filter { activity in
        !bookmarkList.contains { bookmark in
          bookmark.title == activity.title
        }
      }
  }
}
