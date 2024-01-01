//
//  StartInteractor.swift
//  
//
//  Created by 이상헌 on 11/11/23.
//

import OSLog

import RIBs
import RxSwift

import Start
import Usecase

// MARK: - StartPresentable

protocol StartPresentable: Presentable {
  var listener: StartPresentableListener? { get set }
}

// MARK: - StartInteractor

final class StartInteractor: 
  PresentableInteractor<StartPresentable>,
  StartInteractable,
  StartPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: StartRouting?
  weak var listener: StartListener?
  private let timeLogUsecase: TimeLogUsecase
  
  // MARK: - Initialization & DeInitialization
  
  init(
    presenter: StartPresentable,
    timeLogUsecase: TimeLogUsecase
  ) {
    self.timeLogUsecase = timeLogUsecase
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
    router?.attachLogEntryCreationRIB()
  }
  
  func loadData() {
    _ = timeLogUsecase.reloadAllData()
      .subscribe(with: self) { owner, _ in
        os_log(.debug, log: .presenter, "reload is success")
      } onFailure: { owner, error in
        os_log(.error, log: .presenter, "%@", error.localizedDescription)
      }
  }
}
