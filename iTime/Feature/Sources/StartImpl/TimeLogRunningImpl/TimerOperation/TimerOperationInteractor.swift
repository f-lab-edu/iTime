//
//  TimerOperationInteractor.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs
import RxSwift

import Usecase
import Start

// MARK: - TimerOperationPresentable

protocol TimerOperationPresentable: Presentable {
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
  private var isTimeRunning: Bool = true {
    didSet {
      self.presenter.isTimeRunning(isTimeRunning)
    }
  }
  
  // MARK: - Initialization & DeInitialization
  
  init(
    presenter: TimerOperationPresentable,
    timerUsecase: TimerUsecase
  ) {
    self.timerUsecase = timerUsecase
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  func didTapStartButton() {
    timerUsecase.start()
      .take(1)
      .subscribe(with: self) { owner, _ in
        owner.isTimeRunning = true
      }
      .disposeOnDeactivate(interactor: self)
  }
  
  func didTapPauseButton() {
    timerUsecase.suspend()
    isTimeRunning = false
  }
  
  func didTapStopButton() {
    timerUsecase.finish( .init(title: "Test", category: .empty))
      .take(1)
      .subscribe(with: self) { owner, _ in
        owner.listener?.detachTimeLogRunningRIB()
      }
      .disposeOnDeactivate(interactor: self)
  }
}
