//
//  DateSelectionInteractor.swift
//  
//
//  Created by 이상헌 on 12/7/23.
//

import RIBs
import RxSwift

import DateSelection

// MARK: - DateSelectionPresentable

protocol DateSelectionPresentable: Presentable {
  var listener: DateSelectionPresentableListener? { get set }
}

// MARK: - DateSelectionInteractor

final class DateSelectionInteractor: 
  PresentableInteractor<DateSelectionPresentable>,
  DateSelectionInteractable,
  DateSelectionPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: DateSelectionRouting?
  weak var listener: DateSelectionListener?
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: DateSelectionPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
}
