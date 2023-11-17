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
    static let separatedViewHeight: CGFloat = 9
  }
  
  // MARK: - Properties
  
  weak var listener: BookmarkEditorPresentableListener?
  
  // MARK: - UI Components
  
  private let customNavigationBar = CustomNavigationBar()
  
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
    view.addSubview(currentSavedItemsSectionView)
    view.addSubview(separatedView)
    view.addSubview(itemHistorySectionView)
    view.addSubview(saveBookmarkButtonSectionView)
    
    layout()
  }
  
  private func layout() {
    makeCurrentSavedItemSectionViewConstraints()
    makeSeparatedViewConstraints()
    makeItemHistorySectionViewConstraints()
    makeSaveBookmarkButtonSectionViewConstraints()
  }
  
  private func makeCurrentSavedItemSectionViewConstraints() {
    currentSavedItemsSectionView.snp.makeConstraints {
      $0.leading.top.trailing.equalToSuperview()
    }
  }
  
  private func makeSeparatedViewConstraints() {
    separatedView.snp.makeConstraints {
      $0.top.equalTo(currentSavedItemsSectionView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(Metric.separatedViewHeight)
    }
  }
  
  private func makeItemHistorySectionViewConstraints() {
    itemHistorySectionView.snp.makeConstraints {
      $0.top.equalTo(separatedView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(saveBookmarkButtonSectionView.snp.top)
    }
  }
  
  private func makeSaveBookmarkButtonSectionViewConstraints() {
    saveBookmarkButtonSectionView.snp.makeConstraints {
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  BookmarkEditorViewController()
}
#endif
