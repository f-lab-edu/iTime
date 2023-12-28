//
//  TimeLogRunningViewController.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI
import AppFoundation

// MARK: - TimeLogRunningPresentableListener

protocol TimeLogRunningPresentableListener: AnyObject {
  func didTapBackButton()
}

// MARK: - TimeLogRunningViewController

final class TimeLogRunningViewController:
  BaseViewController,
  TimeLogRunningPresentable,
  TimeLogRunningViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    static let tagViewTopMargin: CGFloat = 88
    static let mainCurrentTimeLabelTopMargin: CGFloat = 44
    static let datePickerSectionViewTopMargin: CGFloat = 52
    static let timeOperatorButtonsViewBottomMargin: CGFloat = 140
  }
  
  // MARK: - Properties
  
  weak var listener: TimeLogRunningPresentableListener?
  
  // MARK: - UI Components
  
  private let customNavigationBar = CustomNavigationBar().builder
    .with {
  
    }
    .build()
  
  private let currentActivityView = UIView()
  
  private let currentTimerTimeView = UIView()
  
  private lazy var datePickerSectionView = UIView()
  
  private let timeOperatorButtonsView = UIView()
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindActions()
  }
  
}

// MARK: - Bind Action

extension TimeLogRunningViewController {
  private func bindActions() {
    bindDidTapBackButton()
  }
  
  private func bindDidTapBackButton() {
    customNavigationBar.backButton.rx
      .tapWithPreventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in owner.listener?.didTapBackButton() }
      .disposed(by: disposeBag)
  }
}

// MARK: - Bind State

extension TimeLogRunningViewController {
  
}

// MARK: - Layout

extension TimeLogRunningViewController {
  private func setupUI() {
    view.addSubview(customNavigationBar)
    view.addSubview(currentActivityView)
    view.addSubview(currentTimerTimeView)
    view.addSubview(datePickerSectionView)
    view.addSubview(timeOperatorButtonsView)
    
    layout()
  }
  
  private func layout() {
    makeCustomNavigationBarConstraints()
    makeTagViewConstraints()
    makeMainCurrentTimeLabelConstraints()
    makeDatePickerSectionViewConstraints()
    makeTimeOperatorButtonsViewConstraints()
  }
  
  private func makeCustomNavigationBarConstraints() {
    customNavigationBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
    }
  }
  
  private func makeTagViewConstraints() {
    currentActivityView.snp.makeConstraints {
      $0.top.equalTo(customNavigationBar.snp.bottom).offset(Metric.tagViewTopMargin)
      $0.centerX.equalToSuperview()
    }
  }
  
  private func makeMainCurrentTimeLabelConstraints() {
    currentTimerTimeView.snp.makeConstraints {
      $0.top.equalTo(currentActivityView.snp.bottom).offset(Metric.mainCurrentTimeLabelTopMargin)
      $0.centerX.equalToSuperview()
    }
  }
  
  private func makeDatePickerSectionViewConstraints() {
    datePickerSectionView.snp.makeConstraints {
      $0.top.equalTo(currentTimerTimeView.snp.bottom).offset(Metric.datePickerSectionViewTopMargin)
      $0.leading.trailing.greaterThanOrEqualToSuperview().priority(.low)
      $0.centerX.equalToSuperview()
    }
  }
  
  private func makeTimeOperatorButtonsViewConstraints() {
    timeOperatorButtonsView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-Metric.timeOperatorButtonsViewBottomMargin)
    }
  }
  
  func addCurrentActivity(_ view: ViewControllable) {
    addChildViewController(container: currentActivityView, child: view)
  }
  
  func addCurrentTimerTime(_ view: ViewControllable) {
    addChildViewController(container: currentTimerTimeView, child: view)
  }
  
  func addActivityDatePicker(_ view: ViewControllable) {
    addChildViewController(container: datePickerSectionView, child: view)
  }
  
  func addTimerOperation(_ view: ViewControllable) {
    addChildViewController(container: timeOperatorButtonsView, child: view)
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  TimeLogRunningViewController()
}
#endif
