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
  
  private lazy var itemHistorySectionView = ItemHistorySectionView(delegateDataSource: listener)
  
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
    view.addSubview(itemHistorySectionView)
    
    layout()
  }
  
  private func layout() {
    
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  ActivityHistoryViewController()
}
#endif
