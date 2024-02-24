//
//  CategoryEditorViewController.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - CategoryEditorPresentableListener

protocol CategoryEditorPresentableListener: AnyObject {
  func didTapBackButton()
}

// MARK: - CategoryEditorViewController

final class CategoryEditorViewController:
  BaseViewController,
  CategoryEditorPresentable,
  CategoryEditorViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    static let guideLabelTopMargin: CGFloat = 10
    static let currentActivityTopMargin: CGFloat = 60
    static let categoryListViewHeightRatio: CGFloat = 0.48
    static let categoryListViewRadius: CGFloat = 24
  }
  
  // MARK: - Properties
  
  weak var listener: CategoryEditorPresentableListener?
  
  // MARK: - UI Components
  
  private let closeNavigationBar = CloseNavigationBar()
  
  private let guideLabel = UILabel().builder
    .text("실행하는 동안 시간은 잠시 멈출게요.")
    .textColor(.black60)
    .build()
  
  private let currentActivityContainerView = UIView()
  
  private let categoryListContrainerView = UIView().builder
    .set(\.layer.cornerRadius, to: Metric.categoryListViewRadius)
    .set(\.layer.masksToBounds, to: true)
    .set(\.layer.maskedCorners, to: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
    .build()
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindActions()
  }
  
}

// MARK: - Action

extension CategoryEditorViewController {
  private func bindActions() {
    bindDidTapCloseButtonAction()
  }
  
  private func bindDidTapCloseButtonAction() {
    closeNavigationBar.closeButton.rx
      .tapWithPreventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in
        owner.listener?.didTapBackButton()
      }
      .disposed(by: disposeBag)
  }
}

// MARK: - Layout

extension CategoryEditorViewController {
  private func setupUI() {
    view.addSubview(closeNavigationBar)
    view.addSubview(guideLabel)
    view.addSubview(currentActivityContainerView)
    view.addSubview(categoryListContrainerView)
    
    layout()
  }
  
  private func layout() {
    makeCloseNavigationBarConstraints()
    makeGuideLabelConstraints()
    makeCurrentActivityContainerViewContraints()
    makeCategoryListContainerViewConstraints()
  }
  
  private func makeCloseNavigationBarConstraints() {
    closeNavigationBar.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
    }
  }
  
  private func makeGuideLabelConstraints() {
    guideLabel.snp.makeConstraints {
      $0.centerX.equalToSuperview()
      $0.top.equalTo(closeNavigationBar.snp.bottom).offset(Metric.guideLabelTopMargin)
    }
  }
  
  private func makeCurrentActivityContainerViewContraints() {
    currentActivityContainerView.snp.makeConstraints {
      $0.top.greaterThanOrEqualTo(guideLabel.snp.bottom).offset(Metric.currentActivityTopMargin)
      $0.centerX.equalToSuperview()
    }
  }
  
  private func makeCategoryListContainerViewConstraints() {
    categoryListContrainerView.snp.makeConstraints {
      $0.leading.bottom.trailing.equalToSuperview()
      $0.height.equalToSuperview().multipliedBy(Metric.categoryListViewHeightRatio)
    }
  }
  
  func addCurrentActivity(_ view: RIBs.ViewControllable) {
    addChildViewController(container: currentActivityContainerView, child: view)
  }
  
  func addCategoryList(_ view: ViewControllable) {
    addChildViewController(container: categoryListContrainerView, child: view)
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  CategoryEditorViewController()
}
#endif
