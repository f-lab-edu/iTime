//
//  ActivityHistoryViewController.swift
//
//
//  Created by 이상헌 on 12/10/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI
import AppFoundation

// MARK: - ActivityHistoryPresentableListener

protocol ActivityHistoryPresentableListener:
  AnyObject,
  BookmarkCollectionViewCellDelegate,
  BookmarkTagsCollectionViewAdapterDataSource
{
  func loadActivityList()
}

// MARK: - ActivityHistoryViewController

final class ActivityHistoryViewController:
  BaseViewController,
  ActivityHistoryPresentable,
  ActivityHistoryViewControllable,
  ErrorAlertable
{
  
  // MARK: - Constants
  
  private enum Metric {
    static let emptyGuideLabelTopMargin: CGFloat = 4
  }
  
  // MARK: - Properties
  
  weak var listener: ActivityHistoryPresentableListener?
  
  // MARK: - UI Components
  
  private let activityHistoryCollectionView = DynamicHeightCollectionView(
    frame: .zero,
    collectionViewLayout: .init()
  ).builder
    .backgroundColor(.clear)
    .build()
  
  private lazy var adapter = BookmarkTagsCollectionViewAdapter(
    collectionView: activityHistoryCollectionView,
    adapterDataSource: listener,
    delegate: listener,
    alignedCollectionViewFlowLayout: LeadingAlignedCollectionViewFlowLayout(),
    cellBorderColor: .black60
  )
  
  private lazy var emptyGuideLabel = UILabel().builder
    .numberOfLines(0)
    .font(.custom(.bold, 15))
    .text("아직 기록이 존재하지 않습니다.")
    .textColor(.black60)
    .textAlignment(.center)
    .isHidden(true)
    .build()
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindActions()
  }
  
  func presentError(_ error: DisplayErrorMessage) {
    showErrorAlert(with: error)
  }
  
  func hiddenEmptyIfNeeded(_ isHidden: Bool) {
    emptyGuideLabel.isHidden = isHidden
  }
  
  func reloadActivities() {
    activityHistoryCollectionView.reloadData()
  }
  
}

// MARK: - Bind Action

extension ActivityHistoryViewController {
  private func bindActions() {
    bindLoadActivityList()
  }
  
  private func bindLoadActivityList() {
    rx.viewWillAppear
      .throttle(.seconds(1), latest: false, scheduler: MainScheduler.instance)
      .subscribe(with: self) { owner, _ in
        owner.listener?.loadActivityList()
      }
      .disposed(by: disposeBag)
  }
}

// MARK: - Layout

extension ActivityHistoryViewController {
  private func setupUI() {
    view.addSubview(activityHistoryCollectionView)
    view.addSubview(emptyGuideLabel)
    _ = adapter
    
    layout()
  }
  
  private func layout() {
    makeActivityHistoryCollectionViewConstraints()
    makeEmptyGuideLabelConstraints()
  }
  
  private func makeActivityHistoryCollectionViewConstraints() {
    activityHistoryCollectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func makeEmptyGuideLabelConstraints() {
    emptyGuideLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  ActivityHistoryViewController()
}
#endif
