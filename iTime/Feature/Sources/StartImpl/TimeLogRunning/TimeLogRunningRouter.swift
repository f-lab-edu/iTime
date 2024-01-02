//
//  TimeLogRunningRouter.swift
//
//
//  Created by 이상헌 on 11/25/23.
//

import RIBs

import Start

// MARK: - TimeLogRunningInteractable

public protocol TimeLogRunningInteractable:
  Interactable,
  CurrentActivityListener,
  CurrentTimerTimeListener,
  ActivityDatePickerListener,
  TimerOperationListener
{
  var router: TimeLogRunningRouting? { get set }
  var listener: TimeLogRunningListener? { get set }
}

// MARK: - TimeLogRunningViewControllable

public protocol TimeLogRunningViewControllable: ViewControllable {
  func addCurrentActivity(_ view: ViewControllable)
  func addCurrentTimerTime(_ view: ViewControllable)
  func addActivityDatePicker(_ view: ViewControllable)
  func addTimerOperation(_ view: ViewControllable)
}

// MARK: - TimeLogRunningRouter

final class TimeLogRunningRouter:
  ViewableRouter<TimeLogRunningInteractable,
  TimeLogRunningViewControllable>,
  TimeLogRunningRouting
{
  
  // MARK: - Properties
  
  private let currentActivityBuilder: CurrentActivityBuildable
  private var currentActivityRouter: CurrentActivityRouting?
  
  private let currentTimerTimeBuilder: CurrentTimerTimeBuildable
  private var currentTimerTimeRouter: CurrentTimerTimeRouting?
  
  private let activityDatePickerBuilder: ActivityDatePickerBuildable
  private var activityDatePickerRouter: ActivityDatePickerRouting?
  
  private let timerOperationBuilder: TimerOperationBuildable
  private var timerOperationRouter: TimerOperationRouting?
  
  // MARK: - Initialization & DeInitialization
  
  init(
    interactor: TimeLogRunningInteractable,
    viewController: TimeLogRunningViewControllable,
    currentActivityBuilder: CurrentActivityBuildable,
    currentTimerTimeBuilder: CurrentTimerTimeBuildable,
    activityDatePickerBuilder: ActivityDatePickerBuildable,
    timerOperationBuilder: TimerOperationBuildable
  ) {
    self.currentActivityBuilder = currentActivityBuilder
    self.currentTimerTimeBuilder = currentTimerTimeBuilder
    self.activityDatePickerBuilder = activityDatePickerBuilder
    self.timerOperationBuilder = timerOperationBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  override func didLoad() {
    super.didLoad()
    attachCurrentActivityRIB()
    attachCurrentTimerTimeRIB()
    attachActivityDatePickerRIB()
    attachTimerOperationRIB()
  }
  
  // MARK: Route methods
  
  func attachCurrentActivityRIB() {
    guard currentActivityRouter == nil else { return }
    let router = currentActivityBuilder.build(
      withListener: interactor
    )
    currentActivityRouter = router
    attachChild(router)
    viewController.addCurrentActivity(router.viewControllable)
  }
  
  func attachCurrentTimerTimeRIB() {
    guard currentTimerTimeRouter == nil else { return }
    let router = currentTimerTimeBuilder.build(
      withListener: interactor
    )
    attachChild(router)
    viewController.addCurrentTimerTime(router.viewControllable)
  }
  
  func attachActivityDatePickerRIB() {
    guard activityDatePickerRouter == nil else { return }
    let router = activityDatePickerBuilder.build(
      withListener: interactor
    )
    attachChild(router)
    viewController.addActivityDatePicker(router.viewControllable)
  }
  
  func attachTimerOperationRIB() {
    guard timerOperationRouter == nil else { return }
    let router = timerOperationBuilder.build(
      withListener: interactor
    )
    attachChild(router)
    viewController.addTimerOperation(router.viewControllable)
  }
  
}
