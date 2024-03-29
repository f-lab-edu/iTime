//
//  CurrentActivityInteractor.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs
import RxSwift

import Start

// MARK: - CurrentActivityPresentable

public protocol CurrentActivityPresentable: Presentable {
  var listener: CurrentActivityPresentableListener? { get set }
  func bindTageViewTitle(_ title: String)
}

// MARK: - CurrentActivityInteractor

final class CurrentActivityInteractor: 
  PresentableInteractor<CurrentActivityPresentable>,
  CurrentActivityInteractable,
  CurrentActivityPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: CurrentActivityRouting?
  weak var listener: CurrentActivityListener?
  
  private let activityLogModelStream: ActivityLogModelStream
  private let observationScheduler: SchedulerType
  
  // MARK: - Initialization & DeInitialization
  
  init(
    presenter: CurrentActivityPresentable,
    activityLogModelStream: ActivityLogModelStream,
    observationScheduler: SchedulerType = MainScheduler.asyncInstance
  ) {
    self.activityLogModelStream = activityLogModelStream
    self.observationScheduler = observationScheduler
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  func loadData() {
    activityLogModelStream
      .activityLogStream
      .map(\.title)
      .take(1)
      .observe(on: observationScheduler)
      .subscribe(with: self) { owner, title in
        owner.presenter.bindTageViewTitle(title ?? "내가 지금 할 것은...")
      }
      .disposeOnDeactivate(interactor: self)
  }
  
}
