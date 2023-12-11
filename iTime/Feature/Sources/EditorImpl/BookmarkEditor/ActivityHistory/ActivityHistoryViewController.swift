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

// MARK: - ActivityHistoryPresentableListener

protocol ActivityHistoryPresentableListener: 
  AnyObject,
  BookmarkCollectionViewCellDelegate,
  BookmarkTagsCollectionViewAdapterDataSource
{
}

// MARK: - ActivityHistoryViewController

final class ActivityHistoryViewController:
  BaseViewController,
  ActivityHistoryPresentable,
  ActivityHistoryViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
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
    alignedCollectionViewFlowLayout: LeadingAlignedCollectionViewFlowLayout()
  )
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Bind Action

extension ActivityHistoryViewController {
  
}

// MARK: - Bind State

extension ActivityHistoryViewController {
  
}

// MARK: - Layout

extension ActivityHistoryViewController {
  private func setupUI() {
    view.addSubview(activityHistoryCollectionView)
    _ = adapter
    
    layout()
  }
  
  private func layout() {
    makeActivityHistoryCollectionViewConstraints()
  }
  
  private func makeActivityHistoryCollectionViewConstraints() {
    activityHistoryCollectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  ActivityHistoryViewController()
}
#endif
