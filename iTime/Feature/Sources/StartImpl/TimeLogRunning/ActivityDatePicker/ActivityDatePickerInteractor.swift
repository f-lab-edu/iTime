//
//  ActivityDatePickerInteractor.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs
import RxSwift

import Start

// MARK: - ActivityDatePickerPresentable

protocol ActivityDatePickerPresentable: Presentable {
  var listener: ActivityDatePickerPresentableListener? { get set }
}

// MARK: - ActivityDatePickerInteractor

final class ActivityDatePickerInteractor: 
  PresentableInteractor<ActivityDatePickerPresentable>,
  ActivityDatePickerInteractable,
  ActivityDatePickerPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: ActivityDatePickerRouting?
  weak var listener: ActivityDatePickerListener?
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: ActivityDatePickerPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
}
