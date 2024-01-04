//
//  ActivityDatePickerRouter.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs

import Start

// MARK: - ActivityDatePickerInteractable

public protocol ActivityDatePickerInteractable: Interactable {
  var router: ActivityDatePickerRouting? { get set }
  var listener: ActivityDatePickerListener? { get set }
}

// MARK: - ActivityDatePickerViewControllable

public protocol ActivityDatePickerViewControllable: ViewControllable {
}

// MARK: - ActivityDatePickerRouter

final class ActivityDatePickerRouter:
  ViewableRouter<ActivityDatePickerInteractable,
  ActivityDatePickerViewControllable>,
  ActivityDatePickerRouting
{
  
  // MARK: - Properties
  
  // MARK: - Initialization & DeInitialization
  
  override init(
    interactor: ActivityDatePickerInteractable,
    viewController: ActivityDatePickerViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
}
