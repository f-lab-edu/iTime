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

public protocol TimeLogRunningPresentableListener: AnyObject {
  func didTapBackButton()
  func didTapAddBookmark()
  func didTapDeleteCurrentLog()
}

// MARK: - TimeLogRunningViewController

final class TimeLogRunningViewController:
  BaseViewController,
  TimeLogRunningPresentable,
  TimeLogRunningViewControllable,
  HasActionSheetable
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
  
  private let categoryNavigationBar = CategoryNavigationBar()
  
  private let currentActivityContainerView = UIView()
  
  private let currentTimerTimeContainerView = UIView()
  
  private lazy var datePickerSectionContainerView = UIView()
  
  private let timeOperatorButtonsContainerView = UIView()
  
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
    bindDidTapMoreButton()
  }
  
  private func bindDidTapBackButton() {
    categoryNavigationBar.backButton.rx
      .tapWithPreventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in owner.listener?.didTapBackButton() }
      .disposed(by: disposeBag)
  }
  
  private func bindDidTapMoreButton() {
    categoryNavigationBar.rightItemButton.rx
      .tapWithPreventDuplication()
      .withUnretained(self)
      .flatMap { owner, _ in owner.showActionSheet() }
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, action in
        switch action {
        case .addBookmark: owner.listener?.didTapAddBookmark()
        case .delete: owner.listener?.didTapDeleteCurrentLog()
        }
      }
      .disposed(by: disposeBag)
  }
}

// MARK: - Bind State

extension TimeLogRunningViewController {
  
}

// MARK: - Layout

extension TimeLogRunningViewController {
  private func setupUI() {
    view.addSubview(categoryNavigationBar)
    view.addSubview(currentActivityContainerView)
    view.addSubview(currentTimerTimeContainerView)
    view.addSubview(datePickerSectionContainerView)
    view.addSubview(timeOperatorButtonsContainerView)
    
    layout()
  }
  
  private func layout() {
    makeCategoryNavigationBarConstraints()
    makeTagViewConstraints()
    makeMainCurrentTimeLabelConstraints()
    makeDatePickerSectionViewConstraints()
    makeTimeOperatorButtonsViewConstraints()
  }
  
  private func makeCategoryNavigationBarConstraints() {
    categoryNavigationBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
    }
  }
  
  private func makeTagViewConstraints() {
    currentActivityContainerView.snp.makeConstraints {
      $0.top.equalTo(categoryNavigationBar.snp.bottom).offset(Metric.tagViewTopMargin)
      $0.centerX.equalToSuperview()
    }
  }
  
  private func makeMainCurrentTimeLabelConstraints() {
    currentTimerTimeContainerView.snp.makeConstraints {
      $0.top.equalTo(currentActivityContainerView.snp.bottom).offset(Metric.mainCurrentTimeLabelTopMargin)
      $0.centerX.equalToSuperview()
    }
  }
  
  private func makeDatePickerSectionViewConstraints() {
    datePickerSectionContainerView.snp.makeConstraints {
      $0.top.equalTo(currentTimerTimeContainerView.snp.bottom).offset(Metric.datePickerSectionViewTopMargin)
      $0.leading.trailing.greaterThanOrEqualToSuperview().priority(.low)
      $0.centerX.equalToSuperview()
    }
  }
  
  private func makeTimeOperatorButtonsViewConstraints() {
    timeOperatorButtonsContainerView.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-Metric.timeOperatorButtonsViewBottomMargin)
    }
  }
  
  func addCurrentActivity(_ view: ViewControllable) {
    addChildViewController(container: currentActivityContainerView, child: view)
  }
  
  func addCurrentTimerTime(_ view: ViewControllable) {
    addChildViewController(container: currentTimerTimeContainerView, child: view)
  }
  
  func addActivityDatePicker(_ view: ViewControllable) {
    addChildViewController(container: datePickerSectionContainerView, child: view)
  }
  
  func addTimerOperation(_ view: ViewControllable) {
    addChildViewController(container: timeOperatorButtonsContainerView, child: view)
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  TimeLogRunningViewController()
}
#endif
