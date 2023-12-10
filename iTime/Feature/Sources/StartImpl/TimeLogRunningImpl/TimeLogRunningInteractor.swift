//
//  TimeLogRunningInteractor.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import RIBs
import RxSwift

import Start

// MARK: - TimeLogRunningPresentable

protocol TimeLogRunningPresentable: Presentable {
  var listener: TimeLogRunningPresentableListener? { get set }
}

// MARK: - TimeLogRunningInteractor

final class TimeLogRunningInteractor: 
  PresentableInteractor<TimeLogRunningPresentable>,
  TimeLogRunningInteractable,
  TimeLogRunningPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: TimeLogRunningRouting?
  weak var listener: TimeLogRunningListener?
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: TimeLogRunningPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  func didTapBackButton() {
    listener?.detachTimeLogRunningRIB()
  }
  
}
