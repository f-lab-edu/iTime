//
//  BookmarkEditorViewController.swift
//  
//
//  Created by 이상헌 on 11/14/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - BookmarkEditorPresentableListener

protocol BookmarkEditorPresentableListener: 
  AnyObject,
  BookmarkTagsCollectionViewAdapterDataSource,
  BookmarkCollectionViewCellDelegate
{
}

// MARK: - BookmarkEditorViewController

final class BookmarkEditorViewController:
  BaseViewController,
  BookmarkEditorPresentable,
  BookmarkEditorViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: BookmarkEditorPresentableListener?
  
  // MARK: - UI Components
  
  private let customNavigationBar = CustomNavigationBar()
  
  private let scrollView = UIScrollView()
  
  private let guideView = UIView()
  
  private let contentStackView = UIStackView()
  
  private let selectedItemCountTrackingBar = SelectedItemCountTrackingBar()
  
  private lazy var currentSavedItemsSectionView = CurrentSavedItemsSectionView(listener: listener)
  
  private let separatedView = UIView().builder
    .backgroundColor(.black90)
    .build()
  
  private let itemHistorySectionView = UIView()
  
  private let saveBookmarkButtonSectionView = UIView()
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Bind Action

extension BookmarkEditorViewController {
  
}

// MARK: - Bind State

extension BookmarkEditorViewController {
  
}

// MARK: - Layout

extension BookmarkEditorViewController {
  private func setupUI() {
    
    layout()
  }
  
  private func layout() {
    
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  BookmarkEditorViewController()
}
#endif
