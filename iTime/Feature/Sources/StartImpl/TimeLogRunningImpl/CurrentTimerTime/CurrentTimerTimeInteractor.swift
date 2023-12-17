//
//  CurrentTimerTimeInteractor.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs
import RxSwift

import Entities
import Start

// MARK: - CurrentTimerTimePresentable

protocol CurrentTimerTimePresentable: Presentable {
  var listener: CurrentTimerTimePresentableListener? { get set }
  func currentRunningTime(_ time: String)
}

// MARK: - CurrentTimerTimeInteractor

final class CurrentTimerTimeInteractor: 
  PresentableInteractor<CurrentTimerTimePresentable>,
  CurrentTimerTimeInteractable,
  CurrentTimerTimePresentableListener
{
  
  // MARK: - Properties
  
  weak var router: CurrentTimerTimeRouting?
  weak var listener: CurrentTimerTimeListener?
  
  private let timerInfoModelDataStream: TimerInfoModelDataStream
  
  // MARK: - Initialization & DeInitialization
  
  init(
    presenter: CurrentTimerTimePresentable,
    timerInfoModelDataStream: TimerInfoModelDataStream
  ) {
    self.timerInfoModelDataStream = timerInfoModelDataStream
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  func loadCurrentTime() {
    timerInfoModelDataStream.timerInfoModelDataStream
      .map(\.runningTime)
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, time in
        owner.presenter.currentRunningTime(owner.timeString(time))
      }
      .disposeOnDeactivate(interactor: self)
  }
  
  func timeString(_ time: Int) -> String {
      let hours = time / 3600
      let minutes = time / 60 % 60
      let seconds = time % 60
      return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
  }
  
}
