//
//  BookmarkListViewController.swift
//  
//
//  Created by 이상헌 on 12/10/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - BookmarkListPresentableListener

protocol BookmarkListPresentableListener:
  AnyObject,
  BookmarkCollectionViewCellDelegate,
  BookmarkTagsCollectionViewAdapterDataSource
{

}

// MARK: - BookmarkListViewController

final class BookmarkListViewController:
  BaseViewController,
  BookmarkListPresentable,
  BookmarkListViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: BookmarkListPresentableListener?
  
  // MARK: - UI Components
  private let bookmarkTagsCollectionView = DynamicHeightCollectionView(
    frame: .zero,
    collectionViewLayout: .init()
  ).builder
    .backgroundColor(.clear)
    .build()
  
  private lazy var adapter = BookmarkTagsCollectionViewAdapter(
    collectionView: bookmarkTagsCollectionView,
    adapterDataSource: listener,
    delegate: listener,
    alignedCollectionViewFlowLayout: CenterAlignedCollectionViewFlowLayout()
  )
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

}

// MARK: - Bind Action

extension BookmarkListViewController {
  private func bindActions() {
    
  }

}

// MARK: - Bind State

extension BookmarkListViewController {
  
}

// MARK: - Layout

extension BookmarkListViewController {
  private func setupUI() {
    view.backgroundColor = .clear
    view.addSubview(bookmarkTagsCollectionView)
    _ = adapter
    
    layout()
  }
  
  private func layout() {
    makeBookmarkTagsCollectionViewConstraints()
  }
  
  private func makeBookmarkTagsCollectionViewConstraints() {
    bookmarkTagsCollectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  BookmarkListViewController()
}
#endif
