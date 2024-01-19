//
//  CategoryCreationViewController.swift
//  
//
//  Created by 이상헌 on 12/7/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - CategoryCreationPresentableListener

protocol CategoryCreationPresentableListener: AnyObject {
}

// MARK: - CategoryCreationViewController

final class CategoryCreationViewController:
  BaseViewController,
  CategoryCreationPresentable,
  CategoryCreationViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    static let sectionVeritcalInset: CGFloat = 40.0
    static let sectionHorizontalInset: CGFloat = 24.0
    static let categoryToastViewTopMargin: CGFloat = 8.0
  }
  
  // MARK: - Properties
  
  weak var listener: CategoryCreationPresentableListener?
  
  // MARK: - UI Components
  
  private let customNavigationBar = CustomNavigationBar()
  
  private let categoryToastView = CategoryToastView()
  
  private let categoryTextEntryContainerView = UIView()
  
  private let colorPickerContainerView = UIView()
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Layout

extension CategoryCreationViewController {
  private func setupUI() {
    view.addSubview(customNavigationBar)
    view.addSubview(categoryTextEntryContainerView)
    view.addSubview(colorPickerContainerView)
    view.addSubview(categoryToastView)
    
    layout()
  }
  
  private func layout() {
    makeCustomNavigationBarConstraints()
    makeCategoryTextEntryContainerViewConstraints()
    makeColorPickerContainerViewConstraints()
    makeCategoryToastViewConstraints()
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
  
  private func makeCategoryToastViewConstraints() {
    categoryToastView.snp.makeConstraints {
      $0.top.equalTo(customNavigationBar.snp.bottom).offset(Metric.categoryToastViewTopMargin)
      $0.centerX.equalToSuperview()
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
