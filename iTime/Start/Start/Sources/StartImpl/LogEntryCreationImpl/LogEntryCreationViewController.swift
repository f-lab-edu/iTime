//
//  LogEntryCreationViewController.swift
//
//
//  Created by 이상헌 on 2023/11/05.
//

import UIKit

import RIBs
import RxSwift

import SharedUI
import AppFoundation

// MARK: - LogEntryCreationPresentableListener

protocol LogEntryCreationPresentableListener: AnyObject {
}

// MARK: - LogEntryCreationViewController

final class LogEntryCreationViewController:
  UIViewController,
  LogEntryCreationPresentable,
  LogEntryCreationViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    static let todayDateBarHeight: CGFloat = 52
    static let encouragingBoxViewHeight: CGFloat = 60
    static let buttonsLeadingTrailingMargin: CGFloat = 24
    static let buttonsHeight: CGFloat = 52
    static let editorRoutingButtonTopMargin: CGFloat = 58
    static let startButtonsTopMargin: CGFloat = 12
    static let startButtonsMinimumBottomMargin: CGFloat = 12
    static let buttonsRadious: CGFloat = 8
  }
  
  // MARK: - Properties
  
  weak var listener: LogEntryCreationPresentableListener?
  
  // MARK: - UI Components
  
  private lazy var todayDateBar = TodayDateBar().builder
    .backgroundColor(.clear)
    .build()
  
  private lazy var encouragingBoxView = EncouragingBoxView()
  
  private lazy var frameView = UIView().builder
    .backgroundColor(.blue)
    .build()
  
  private lazy var editorRoutingButton = UIButton().builder
    .set(\.layer.cornerRadius, to: Metric.buttonsRadious)
    .backgroundColor(.black90)
    .with {
      $0.setTitle("내가 지금 할 것은...", for: .normal)
      $0.setTitleColor(.black60, for: .normal)
    }
    .build()
  
  private lazy var startButton = UIButton().builder
    .set(\.layer.cornerRadius, to: Metric.buttonsRadious)
    .backgroundColor(.pointGreen)
    .with {
      $0.setImage(.start, for: .normal)
    }
    .build()
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Layout

extension LogEntryCreationViewController {
  private func setupUI() {
    view.backgroundColor = .black100
    view.addSubview(todayDateBar)
    view.addSubview(encouragingBoxView)
    view.addSubview(frameView)
    view.addSubview(editorRoutingButton)
    view.addSubview(startButton)
    
    layout()
  }
  
  private func layout() {
    makeTodayDateBarConstraints()
    makeEncouragingBoxViewConstraints()
    makeFrameViewConstraints()
    makeEditorRoutingButtonConstraints()
    makeStartButtonConstraints()
  }
  
  private func makeTodayDateBarConstraints() {
    todayDateBar.snp.makeConstraints {
      $0.top.equalToSuperview().offset(Layout.safeAreaTopHeight)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(Metric.todayDateBarHeight)
    }
  }
  
  private func makeEncouragingBoxViewConstraints() {
    encouragingBoxView.snp.makeConstraints {
      $0.top.equalTo(todayDateBar.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(Metric.encouragingBoxViewHeight)
    }
  }
  
  private func makeFrameViewConstraints() {
    frameView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.size.equalTo(200)
    }
  }
  
  private func makeEditorRoutingButtonConstraints() {
    editorRoutingButton.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(Metric.buttonsLeadingTrailingMargin)
      $0.top.equalTo(frameView.snp.bottom).offset(Metric.editorRoutingButtonTopMargin)
      $0.height.equalTo(Metric.buttonsHeight)
    }
  }
  
  private func makeStartButtonConstraints() {
    startButton.snp.makeConstraints {
      $0.height.leading.trailing.equalTo(editorRoutingButton)
      $0.top.equalTo(editorRoutingButton.snp.bottom).offset(Metric.startButtonsTopMargin)
      $0.bottom.greaterThanOrEqualToSuperview().offset(-Metric.startButtonsMinimumBottomMargin).priority(.high)
    }
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  let vc = LogEntryCreationViewController()
  return vc
}
#endif
