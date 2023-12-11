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
    static let emptyGuideLabelTopMargin: CGFloat = 4
    static let emptyGuideLabelBottomMargin: CGFloat = 24
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
  
  private let emptyGuideLabel = UILabel().builder
    .text("자주 하시는 활동으로 저장해보세요!")
    .font(.custom(.regular, 12))
    .textColor(.black60)
    .isHidden(true)
    .build()
  
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
    view.addSubview(emptyGuideLabel)
    _ = adapter
    
    layout()
  }
  
  private func layout() {
    makeBookmarkTagsCollectionViewConstraints()
    makeEmptyGuideLabelConstraints()
  }
  
  private func makeBookmarkTagsCollectionViewConstraints() {
    bookmarkTagsCollectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
  
  private func makeEmptyGuideLabelConstraints() {
    emptyGuideLabel.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalToSuperview().offset(Metric.emptyGuideLabelTopMargin)
      $0.bottom.equalToSuperview().offset(-Metric.emptyGuideLabelBottomMargin).priority(.low)
    }
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  BookmarkListViewController()
}
#endif
