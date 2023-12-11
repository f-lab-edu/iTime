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
  func didTapBookmarkTagEditor()
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
  
  private lazy var bookmarkTagsView = BookmarkTagsView(listener: listener)
  
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Bind Action

extension BookmarkListViewController {
  private func bindActions() {
    bindBookmarkTagsEditButtonTapAction()
  }
  
  private func bindBookmarkTagsEditButtonTapAction() {
    bookmarkTagsView.bookmarkEditorButtonLabel.rx
      .tapGestureWithPreventDuplication()
      .asDriver(onErrorDriveWith: .empty())
            .drive(with: self) { owner, _ in owner.listener?.didTapBookmarkTagEditor() }
      .disposed(by: disposeBag)
  }
}

// MARK: - Bind State

extension BookmarkListViewController {
  
}

// MARK: - Layout

extension BookmarkListViewController {
  private func setupUI() {
    view.backgroundColor = .clear
    view.addSubview(bookmarkTagsView)
    
    layout()
  }
  
  private func layout() {
    makeBookmarkTagsViewConstraints()
  }
  
  private func makeBookmarkTagsViewConstraints() {
    bookmarkTagsView.snp.makeConstraints {
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
