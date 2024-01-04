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
  private let observationScheduler: SchedulerType
  
  // MARK: - Initialization & DeInitialization
  
  init(
    presenter: TimerOperationPresentable,
    timerUsecase: TimerUsecase,
    activityLogModelStream: ActivityLogModelStream,
    observationScheduler: SchedulerType = MainScheduler.asyncInstance
  ) {
    self.timerUsecase = timerUsecase
    self.activityLogModelStream = activityLogModelStream
    self.observationScheduler = observationScheduler
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
      .withUnretained(self)
      .take(1)
      .observe(on: observationScheduler)
      .subscribe(with: self) { owner, _ in
        owner.listener?.detachTimeLogRunningRIB()
      }
      .disposeOnDeactivate(interactor: self)
  }
  
}
