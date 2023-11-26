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
  SavedItemSectionDelegateDataSource,
  ItemHistorySectionDelegateDataSource
{
  func didTapSaveButton()
  func didTapAddButton()
  func didTapBackButton()
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
  
  private lazy var itemHistorySectionView = ItemHistorySectionView(listener: listener)
  
  private let saveBookmarkButtonSectionView = SaveBookmarkButtonSectionView()
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindActions()
  }
  
}

// MARK: - Bind Action

extension BookmarkEditorViewController {
  private func bindActions() {
    bindSaveButtonTapAction()
    bindAddButtonTapAction()
    bindBackButtonTapAction()
  }
  
  private func bindSaveButtonTapAction() {
    saveBookmarkButtonSectionView.saveButton.rx
      .tapWithPreventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in print("tap") }
      .disposed(by: disposeBag)
  }
  
  private func bindAddButtonTapAction() {
    customNavigationBar.addButton.rx
      .tapWithPreventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in print("tap") }
      .disposed(by: disposeBag)
  }
  
  private func bindBackButtonTapAction() {
    customNavigationBar.backButton.rx
      .tapWithPreventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in print("tap") }
      .disposed(by: disposeBag)
  }
  
}

// MARK: - Bind State

extension BookmarkEditorViewController {
  
}

extension BookmarkEditorViewController {
  
}

// MARK: - Layout

extension BookmarkEditorViewController {
  private func setupUI() {
    view.addSubview(customNavigationBar)
    view.addSubview(currentSavedItemsSectionView)
    view.addSubview(separatedView)
    view.addSubview(itemHistorySectionView)
    view.addSubview(saveBookmarkButtonSectionView)
    
    layout()
  }
  
  private func layout() {
    makeCustomNavigationBarConstraints()
    makeCurrentSavedItemSectionViewConstraints()
    makeSeparatedViewConstraints()
    makeItemHistorySectionViewConstraints()
    makeSaveBookmarkButtonSectionViewConstraints()
  }
  
  private func makeCustomNavigationBarConstraints() {
    customNavigationBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
    }
  }
  
  private func makeCurrentSavedItemSectionViewConstraints() {
    currentSavedItemsSectionView.snp.makeConstraints {
      $0.top.equalTo(customNavigationBar.snp.bottom)
      $0.leading.trailing.equalToSuperview()
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
      $0.bottom.equalTo(saveBookmarkButtonSectionView.snp.top).priority(.low)
    }
  }
  
  private func makeSaveBookmarkButtonSectionViewConstraints() {
    saveBookmarkButtonSectionView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  let vc = BookmarkEditorViewController()
  return vc
}
#endif
