//
//  LogEntryCreationViewController.swift
//
//
//  Created by 이상헌 on 2023/11/05.
//

import UIKit

import RIBs
import RxSwift

import ProxyPackage

protocol LogEntryCreationPresentableListener: AnyObject {
}

final class LogEntryCreationViewController:
  UIViewController,
  LogEntryCreationPresentable,
  LogEntryCreationViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    static let todayDateBarHeight: CGFloat = 52
    static let encouragingBoxViewHeight: CGFloat = 60
  }
  
  // MARK: - Properties
  
  weak var listener: LogEntryCreationPresentableListener?
  
  // MARK: - UI Components
  
  private lazy var todayDateBar = TodayDateBar().builder
    .backgroundColor(.clear)
    .build()
  
  private lazy var encouragingBoxView = EncouragingBoxView()
  
  
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  
}

// MARK: - Layout

extension LogEntryCreationViewController {
  private func setupUI() {
    view.addSubview(todayDateBar)
    view.addSubview(encouragingBoxView)
    view.backgroundColor = .black100
    
    layout()
  }
  
  private func layout() {
    makeTodayDateBarConstraints()
    makeEncouragingBoxViewConstraints()
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
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  let vc = LogEntryCreationViewController()
  return vc
}
#endif
