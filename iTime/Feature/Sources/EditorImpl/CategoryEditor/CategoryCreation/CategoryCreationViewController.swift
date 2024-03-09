//
//  CategoryCreationViewController.swift
//  
//
//  Created by 이상헌 on 12/7/23.
//

import UIKit

import RIBs
import RxSwift
import PinLayout

import SharedUI

// MARK: - CategoryCreationPresentableListener

protocol CategoryCreationPresentableListener: AnyObject {
  
}

// MARK: - CategoryCreationViewController

final class CategoryCreationViewController:
  BaseViewController,
  CategoryCreationPresentable,
  CategoryCreationViewControllable,
  KeyboardAddable
{
  
  // MARK: - Constants
  
  private enum Metric {
    static let sectionVeritcalInset: CGFloat = 40.0
    static let sectionHorizontalInset: CGFloat = 24.0
    static let categoryToastViewTopMargin: CGFloat = 8.0
    static let selectedCategoryPreviewHeight: CGFloat = 88.0
  }
  
  // MARK: - Properties
  
  weak var listener: CategoryCreationPresentableListener?
  
  // MARK: - UI Components
  
  private let customNavigationBar = CustomNavigationBar().builder
    .with {
      $0.setTitleLabel("카테고리 수정")
      $0.setTitleLabelAlignment(.left)
      $0.setRightButtonTitle("저장")
    }
    .build()
  
  private let categoryToastView = CategoryToastView()
  
  private let categoryTextEntryContainerView = UIView()
  
  private let colorPickerContainerView = UIView()
  
  private let categoryDeletionButton = UIButton()
  
  private let selectedCategoryPreview = SelectedCategoryPreview()
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    addKeyboardObserver()
    setupUI()
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

// MARK: - Layout

extension CategoryCreationViewController {
  private func setupUI() {
    view.addSubview(customNavigationBar)
    view.addSubview(categoryTextEntryContainerView)
    view.addSubview(colorPickerContainerView)
    view.addSubview(categoryToastView)
    view.addSubview(selectedCategoryPreview)
    
    layout()
  }
  
  private func layout() {
    makeCustomNavigationBarConstraints()
    makeCategoryTextEntryContainerViewConstraints()
    makeColorPickerContainerViewConstraints()
    makeCategoryToastViewConstraints()
    makeSelectedCategoryPreviewConstraints()
  }
  
  private func makeCustomNavigationBarConstraints() {
    customNavigationBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
    }
  }
  
  private func makeCategoryToastViewConstraints() {
    categoryToastView.snp.makeConstraints {
      $0.top.equalTo(customNavigationBar.snp.bottom).offset(Metric.categoryToastViewTopMargin)
      $0.centerX.equalToSuperview()
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
  CategoryCreationViewController()
}
#endif
