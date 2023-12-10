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
  
  private let customNavigationBar = CustomNavigationBar()
  
  private let tagView = TagView().builder
    .with {
      $0.configure(by: "영어공부")
    }
    .build()
  
  private let mainCurrentTimeLabel = UILabel().builder
    .text("0:00:03")
    .font(.custom(.bold, 40))
    .textColor(.white)
    .build()
  
  private lazy var datePickerSectionView = DatePickerSectionView(timeFormatter: timeFormatter)
  
  private let timeOperatorButtonsView = TimeOperatorButtonsView()
  
  // MARK: - Properties
  private let timeFormatter: TimeFormatter
  
  // MARK: - Initialziation
  
  init(timeFormatter: TimeFormatter) {
    self.timeFormatter = timeFormatter
  }
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Bind Action

extension TimeLogRunningViewController {
  
}

// MARK: - Bind State

extension TimeLogRunningViewController {
  
}

// MARK: - Layout

extension TimeLogRunningViewController {
  private func setupUI() {
    view.addSubview(customNavigationBar)
    view.addSubview(tagView)
    view.addSubview(mainCurrentTimeLabel)
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
    tagView.snp.makeConstraints {
      $0.top.equalTo(customNavigationBar.snp.bottom).offset(Metric.tagViewTopMargin)
      $0.centerX.equalToSuperview()
    }
  }
  
  private func makeMainCurrentTimeLabelConstraints() {
    mainCurrentTimeLabel.snp.makeConstraints {
      $0.top.equalTo(tagView.snp.bottom).offset(Metric.mainCurrentTimeLabelTopMargin)
      $0.centerX.equalToSuperview()
    }
  }
  
  private func makeDatePickerSectionViewConstraints() {
    datePickerSectionView.snp.makeConstraints {
      $0.top.equalTo(mainCurrentTimeLabel.snp.bottom).offset(Metric.datePickerSectionViewTopMargin)
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
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  TimeLogRunningViewController(timeFormatter: TimeFormatterImpl())
}
#endif
