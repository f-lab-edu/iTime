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
import AppFoundation

// MARK: - BookmarkEditorPresentableListener

protocol BookmarkEditorPresentableListener: AnyObject {
  func didTapSaveButton()
  func didTapAddButton()
  func didTapBackButton()
}

// MARK: - BookmarkEditorViewController

final class BookmarkEditorViewController:
  BaseViewController,
  BookmarkEditorPresentable,
  BookmarkEditorViewControllable,
  ErrorAlertable
{
   
  // MARK: - Constants
  
  private enum Metric {
    static let separatedViewHeight: CGFloat = 9
    static let sectionHeaderTitleLabelTopMargin: CGFloat = 16
    static let sectionHeaderTitleLabelLeadingMargin: CGFloat = 24
    static let sectionHeaderTitleLabelHeight: CGFloat = 24
    static let currentCountIndexLabelTrailingMargin: CGFloat = 24
    static let guideLabelHeight: CGFloat = 20
    static let guideLabelTopMargin: CGFloat = 4
    static let separationTopMargin: CGFloat = 24
  }
  
  // MARK: - Properties
  
  weak var listener: BookmarkEditorPresentableListener?
  
  // MARK: - UI Components
  
  private let customNavigationBar = CustomNavigationBar()
  
  private let bookmarkListSectionHeaderTitleLabel = UILabel().builder
    .text("현재 저장된 활동")
    .font(.custom(.bold, 16))
    .textColor(.black40)
    .build()
  
  private let currentCountIndexLabel = UILabel().builder
    .text("3/6")
    .font(.custom(.regular, 16))
    .textColor(.black40)
    .build()
  
  private let bookmarkListContainterView = UIView()
  
  private let separatedView = UIView().builder
    .backgroundColor(.black90)
    .build()
  
  private let activityHistorySectionHeaderTitleLabel = UILabel().builder
    .text("현재 기록")
    .font(.custom(.bold, 16))
    .textColor(.black40)
    .build()
  
  private let guideLabel = UILabel().builder
    .text("자주 했던 활동을 모아 보았어요")
    .font(.custom(.regular, 12))
    .textColor(.black60)
    .build()
  
  private let activityHistoryContainterView = UIView()
  
  private let saveBookmarkButtonSectionView = SaveBookmarkButtonSectionView()
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindActions()
  }
  
  func presentError(_ error: DisplayErrorMessage) {
    showErrorAlert(with: error)
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
      .drive(with: self) { owner, _ in owner.listener?.didTapSaveButton() }
      .disposed(by: disposeBag)
  }
  
  private func bindAddButtonTapAction() {
    customNavigationBar.addButton.rx
      .tapWithPreventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in owner.listener?.didTapAddButton() }
      .disposed(by: disposeBag)
  }
  
  private func bindBackButtonTapAction() {
    customNavigationBar.backButton.rx
      .tapWithPreventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in owner.listener?.didTapBackButton() }
      .disposed(by: disposeBag)
  }
  
}

// MARK: - Layout

extension BookmarkEditorViewController {
  private func setupUI() {
    view.addSubview(customNavigationBar)
    view.addSubview(bookmarkListSectionHeaderTitleLabel)
    view.addSubview(currentCountIndexLabel)
    view.addSubview(bookmarkListContainterView)
    view.addSubview(separatedView)
    view.addSubview(activityHistorySectionHeaderTitleLabel)
    view.addSubview(guideLabel)
    view.addSubview(activityHistoryContainterView)
    view.addSubview(saveBookmarkButtonSectionView)
    
    layout()
  }
  
  private func layout() {
    makeCustomNavigationBarConstraints()
    makeBookmarkListSectionHeaderTitleLabelConstraints()
    makeCurrentCountIndexLabelConstraints()
    makeBookmarkListContainterViewViewConstraints()
    makeSeparatedViewConstraints()
    makeActivityHistorySectionHeaderTitleLabelConstraints()
    makeActivityHistorySectionGuideLabelConstraints()
    makeActivityHistoryContainterViewConstraints()
    makeSaveBookmarkButtonSectionViewConstraints()
  }
  
  private func makeCustomNavigationBarConstraints() {
    customNavigationBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
    }
  }
  
  private func makeBookmarkListSectionHeaderTitleLabelConstraints() {
    bookmarkListSectionHeaderTitleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.sectionHeaderTitleLabelLeadingMargin)
      $0.top.equalTo(customNavigationBar.snp.bottom).offset(Metric.sectionHeaderTitleLabelTopMargin)
      $0.height.equalTo(Metric.sectionHeaderTitleLabelHeight)
    }
  }
  
  private func makeCurrentCountIndexLabelConstraints() {
    currentCountIndexLabel.snp.makeConstraints {
      $0.centerY.equalTo(bookmarkListSectionHeaderTitleLabel)
      $0.trailing.equalToSuperview().offset(-Metric.currentCountIndexLabelTrailingMargin)
      $0.height.equalTo(Metric.sectionHeaderTitleLabelHeight)
    }
  }
  
  private func makeBookmarkListContainterViewViewConstraints() {
    bookmarkListContainterView.snp.makeConstraints {
      $0.top.equalTo(bookmarkListSectionHeaderTitleLabel.snp.bottom)
      $0.leading.equalTo(bookmarkListSectionHeaderTitleLabel)
      $0.trailing.equalTo(currentCountIndexLabel)
    }
  }
  
  private func makeSeparatedViewConstraints() {
    separatedView.snp.makeConstraints {
      $0.top.equalTo(bookmarkListContainterView.snp.bottom).offset(Metric.separationTopMargin).priority(.high)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(Metric.separatedViewHeight)
    }
  }
  
  private func makeActivityHistorySectionHeaderTitleLabelConstraints() {
    activityHistorySectionHeaderTitleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.sectionHeaderTitleLabelLeadingMargin)
      $0.top.equalTo(separatedView.snp.bottom).offset(Metric.sectionHeaderTitleLabelTopMargin)
      $0.height.equalTo(Metric.sectionHeaderTitleLabelHeight)
    }
  }
  
  private func makeActivityHistorySectionGuideLabelConstraints() {
    guideLabel.snp.makeConstraints {
      $0.leading.equalTo(activityHistorySectionHeaderTitleLabel)
      $0.top.equalTo(activityHistorySectionHeaderTitleLabel.snp.bottom).offset(Metric.guideLabelTopMargin)
      $0.height.equalTo(Metric.guideLabelHeight)
    }
  }
  
  private func makeActivityHistoryContainterViewConstraints() {
    activityHistoryContainterView.snp.makeConstraints {
      $0.top.equalTo(guideLabel.snp.bottom)
      $0.leading.trailing.equalTo(bookmarkListContainterView)
      $0.bottom.equalTo(saveBookmarkButtonSectionView.snp.top)
    }
  }
  
  private func makeSaveBookmarkButtonSectionViewConstraints() {
    saveBookmarkButtonSectionView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }
  
  func addBookmarkList(_ view: ViewControllable) {
    addChildViewController(container: bookmarkListContainterView, child: view)
  }
  
  func addActivityHistory(_ view: ViewControllable) {
    addChildViewController(container: activityHistoryContainterView, child: view)
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  let vc = BookmarkEditorViewController()
  return vc
}
#endif
