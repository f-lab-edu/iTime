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
import AppFoundation

// MARK: - BookmarkListPresentableListener

protocol BookmarkListPresentableListener:
  AnyObject,
  BookmarkCollectionViewCellDelegate,
  BookmarkTagsCollectionViewAdapterDataSource
{
  func loadBookmarkList()
}

// MARK: - BookmarkListViewController

final class BookmarkListViewController:
  BaseViewController,
  BookmarkListPresentable,
  BookmarkListViewControllable,
  ErrorAlertable
{
  
  // MARK: - Constants
  
  private enum Metric {
    static let emptyGuideLabelTopMargin: CGFloat = 4
    static let emptyGuideLabelBottomMargin: CGFloat = 24
  }
  
  // MARK: - Properties
  
  weak var listener: BookmarkListPresentableListener?
  private let alignedCollectionViewFlowLayout: UICollectionViewFlowLayout
  private let cellBorderColor: UIColor
  private let emptyLabelText: String
  private let emptyTextAlignment: NSTextAlignment
  
  init(
    alignedCollectionViewFlowLayout: UICollectionViewFlowLayout,
    cellBorderColor: UIColor,
    emptyLabelText: String,
    emptyTextAlignment: NSTextAlignment
  ) {
    self.alignedCollectionViewFlowLayout = alignedCollectionViewFlowLayout
    self.cellBorderColor = cellBorderColor
    self.emptyLabelText = emptyLabelText
    self.emptyTextAlignment = emptyTextAlignment
  }
  
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
    alignedCollectionViewFlowLayout: alignedCollectionViewFlowLayout,
    cellBorderColor: cellBorderColor
  )
  
  private lazy var emptyGuideLabel = UILabel().builder
    .numberOfLines(0)
    .font(.custom(.regular, 12))
    .text(self.emptyLabelText)
    .textColor(.black60)
    .textAlignment(self.emptyTextAlignment)
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
  
  func hiddenEmptyIfneeded(_ isHidden: Bool) {
    emptyGuideLabel.isHidden = isHidden
  }
  
  func reloadBookmarks() {
    bookmarkTagsCollectionView.reloadData()
  }
  
}

// MARK: - Bind Actions

extension BookmarkListViewController {
  private func bindActions() {
    bindLoadBookmarkList()
  }
  
  private func bindLoadBookmarkList() {
    rx.viewWillAppear
      .throttle(.seconds(1), latest: false, scheduler: MainScheduler.instance)
      .subscribe(with: self) { owner, _ in
        owner.listener?.loadBookmarkList()
      }
      .disposed(by: disposeBag)
  }
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
  BookmarkListViewController(alignedCollectionViewFlowLayout: CenterAlignedCollectionViewFlowLayout(), cellBorderColor: .pointGreen, emptyLabelText: "emptyLabel", emptyTextAlignment: .left)
}
#endif
