//
//  CategoryModificationViewController.swift
//  
//
//  Created by 이상헌 on 3/10/24.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - CategoryModificationPresentableListener

protocol CategoryModificationPresentableListener: AnyObject {
  func didTriggerDissapearAction()
}

// MARK: - CategoryModificationViewController

final class CategoryModificationViewController:
  BaseViewController,
  CategoryModificationPresentable,
  CategoryModificationViewControllable,
  KeyboardAddable
{
  
  // MARK: - Constants
  
  private enum Metric {
    static let sectionVeritcalInset: CGFloat = 40.0
    static let sectionHorizontalInset: CGFloat = 24.0
    static let categoryToastViewTopMargin: CGFloat = 8.0
    static let selectedCategoryPreviewHeight: CGFloat = 40.0
    static let categoryDeletionButtonHeight: CGFloat = 40.0
    static let categoryDeletionButtonBottomMargin: CGFloat = 28.0
    static let categoryDeletionButtonWidth: CGFloat = 132.0
  }
  
  // MARK: - Properties
  
  weak var listener: CategoryModificationPresentableListener?
  
  // MARK: - UI Components
  
  private let customNavigationBar = CustomNavigationBar().builder
    .with {
      $0.setTitleLabel("카테고리 수정")
      $0.updateTitleLabelConstraintsToLeft()
      $0.setRightButtonTitle("저장")
    }
    .build()

  private let categoryTextEntryContainerView = UIView()
  
  private let colorPickerContainerView = UIView()
  
  private let categoryDeletionButton = CategoryDeletionButton().builder
    .set(\.layer.masksToBounds, to: true)
    .set(\.layer.cornerRadius, to: 8)
    .build()
  
  private let selectedCategoryPreview = SelectedCategoryPreview()
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addKeyboardObserver()
    setupUI()
    bindActions()
  }
  
  deinit {
    removeKeyboardObserver()
  }
  
  func updateCategoryTitle(with title: String) {
    selectedCategoryPreview.updateTitle(with: title)
  }
  
  func updateCategoryColorHex(with hex: String) {
    selectedCategoryPreview.updateColor(with: UIColor(hex: hex) ?? .gray)
  }
  
}

// MARK: - Bind Action

extension CategoryModificationViewController {
  
}

// MARK: - Bind State

extension CategoryModificationViewController {
  private func bindActions() {
    bindDidTapBackbutton()
    bindDetachAction()
  }
  
  private func bindDidTapBackbutton() {
    customNavigationBar.backButton.rx
      .tapWithPreventDuplication()
      .bind(to: self.detachAction)
      .disposed(by: disposeBag)
  }
  
  private func bindDetachAction() {
    detachAction
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in
        owner.listener?.didTriggerDissapearAction()
      }
      .disposed(by: disposeBag)
  }
}

// MARK: - Layout

extension CategoryModificationViewController {
  private func setupUI() {
    view.addSubview(customNavigationBar)
    view.addSubview(categoryTextEntryContainerView)
    view.addSubview(colorPickerContainerView)
    view.addSubview(categoryDeletionButton)
    view.addSubview(selectedCategoryPreview)
    
    layout()
  }
  
  private func layout() {
    makeCustomNavigationBarConstraints()
    makeCategoryTextEntryContainerViewConstraints()
    makeColorPickerContainerViewConstraints()
    makeCategoryDeletionButtonConstraints()
    makeSelectedCategoryPreviewConstraints()
  }
  
  private func makeCustomNavigationBarConstraints() {
    customNavigationBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
    }
  }
  
  private func makeCategoryTextEntryContainerViewConstraints() {
    categoryTextEntryContainerView.snp.makeConstraints {
      $0.top.equalTo(customNavigationBar.snp.bottom).offset(Metric.sectionVeritcalInset)
      $0.leading.trailing.equalToSuperview().inset(Metric.sectionHorizontalInset)
    }
  }
  
  private func makeColorPickerContainerViewConstraints() {
    colorPickerContainerView.snp.makeConstraints {
      $0.top.equalTo(categoryTextEntryContainerView.snp.bottom).offset(Metric.sectionVeritcalInset)
      $0.leading.trailing.equalTo(categoryTextEntryContainerView)
    }
  }
  
  private func makeCategoryDeletionButtonConstraints() {
    categoryDeletionButton.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.height.equalTo(Metric.categoryDeletionButtonHeight)
      $0.width.equalTo(Metric.categoryDeletionButtonWidth)
      $0.bottom.equalTo(selectedCategoryPreview.snp.top).offset(-Metric.categoryDeletionButtonBottomMargin)
    }
  }
  
  private func makeSelectedCategoryPreviewConstraints() {
    selectedCategoryPreview.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(Metric.selectedCategoryPreviewHeight)
      bottomConstraint = $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint
    }
  }
  
  func addTextEntry(_ view: ViewControllable) {
    addChildViewController(container: categoryTextEntryContainerView, child: view)
  }
  
  func addColorPicker(_ view: ViewControllable) {
    addChildViewController(container: colorPickerContainerView, child: view)
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  CategoryModificationViewController()
}
#endif
