//
//  CategoryListInteractor.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs
import RxSwift
import RxRelay

import Entities
import Editor
import AppFoundation

// MARK: - CategoryListPresentable

public protocol CategoryListPresentable: Presentable {
  var listener: CategoryListPresentableListener? { get set }
}

// MARK: - CategoryListInteractor

final class CategoryListInteractor: 
  PresentableInteractor<CategoryListPresentable>,
  CategoryListInteractable,
  CategoryListPresentableListener
{
  
  var error: Observable<DisplayErrorMessage> {
    state
      .map(\.error)
      .filter { $0 != .noError }
      .map(\.localizedDescription)
      .withUnretained(self)
      .map { owner, message in
        owner.categoryListErrorMessage(message)
      }
  }
  
  var viewModel: Observable<CategoryListViewModel> {
    state
      .map(\.timeLogRecords)
      .distinctUntilChanged()
      .map(CategoryListViewModel.init)
      .catchAndReturn(CategoryListViewModel())
  }
  
  
  // MARK: - Properties
  
  weak var router: CategoryListRouting?
  weak var listener: CategoryListListener?
  private let timeLogRecordModelDataStream: TimeLogRecordModelDataStream
  private let observationScheduler: SchedulerType
  private let state: BehaviorRelay<CategoryListState>
  
  // MARK: - Initialization & DeInitialization
  
  init(
    initialState: BehaviorRelay<CategoryListState>,
    presenter: CategoryListPresentable,
    timeLogRecordModelDataStream: TimeLogRecordModelDataStream,
    observationScheduler: SchedulerType = MainScheduler.asyncInstance
  ) {
    self.state = initialState
    self.timeLogRecordModelDataStream = timeLogRecordModelDataStream
    self.observationScheduler = observationScheduler
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  func loadData() {
    timeLogRecordModelDataStream
      .timeLogRecords
      .catch ({ [weak self] error in
        self?.reduceError(.unknownError(error.localizedDescription))
        return .empty()
      })
      .observe(on: observationScheduler)
      .subscribe(with: self) { owner, timeLogRecords in
        owner.reduceTimeLogRecords(timeLogRecords)
      }
      .disposeOnDeactivate(interactor: self)
  }
  
  func didTapCell(from model: CategoryViewModel) {
    listener?.didTapCategoryListCell(from: model.toCategory())
  }
  
  func didTapCategoryCreationLabel() {
    listener?.didTapCategoryCreationLabel()
  }
  
  private func categoryListErrorMessage(_ message: String) -> DisplayErrorMessage {
      DisplayErrorMessage(
        title: "Bookmark List Error",
        message: message,
        confirmActionTitle: "Confirm"
      )
  }
  
  private func reduceError(_ error: CategoryListError) {
    var newState = state.value
    newState.error = error
    state.accept(newState)
  }
  
  private func reduceTimeLogRecords(_ timeLogRecord: [TimeLogRecord]) {
    var newState = state.value
    newState.timeLogRecords = timeLogRecord
    state.accept(newState)
  }
}
