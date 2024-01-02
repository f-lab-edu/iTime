//
//  TimerOperationInteractor.swift
//
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs
import RxSwift

import Entities
import Usecase
import Start

// MARK: - TimerOperationPresentable

public protocol TimerOperationPresentable: Presentable {
  var listener: TimerOperationPresentableListener? { get set }
  func isTimeRunning(_ isRunning: Bool)
}

// MARK: - TimerOperationInteractor

final class TimerOperationInteractor:
  PresentableInteractor<TimerOperationPresentable>,
  TimerOperationInteractable,
  TimerOperationPresentableListener
{
  
  
  // MARK: - Properties
  
  weak var router: TimerOperationRouting?
  weak var listener: TimerOperationListener?
  private let timerUsecase: TimerUsecase
  private let activityLogModelStream: ActivityLogModelStream
  
  // MARK: - Initialization & DeInitialization
  
  init(
    presenter: TimerOperationPresentable,
    timerUsecase: TimerUsecase,
    activityLogModelStream: ActivityLogModelStream
  ) {
    self.timerUsecase = timerUsecase
    self.activityLogModelStream = activityLogModelStream
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  func didTapStartButton() {
    timerUsecase.start()
    presenter.isTimeRunning(true)
  }
  
  func didTapPauseButton() {
    timerUsecase.suspend()
    presenter.isTimeRunning(false)
  }
  
  func didTapStopButton() {
    activityLogModelStream.activityLogStream
      .map(Activity.toActivity(_:))
      .flatMap(timerUsecase.finish)
      .take(1)
      .subscribe(with: self) { owner, _ in
        owner.listener?.detachTimeLogRunningRIB()
      }
      .disposeOnDeactivate(interactor: self)
  }
  
}
