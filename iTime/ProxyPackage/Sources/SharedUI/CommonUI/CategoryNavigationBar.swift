//
//  File.swift
//  
//
//  Created by 이상헌 on 12/28/23.
//

import UIKit

public final class CategoryNavigationBar: 
  BaseView,
  Configurable
{
  public typealias ViewModel = CategoryNavigationBarViewMdoel
  
  // MARK: - Constants
  
  private enum Metric {
    static let backButtonLeadingMargin: CGFloat = 8
    static let backButtonTopBottomMargin: CGFloat = 4
    static let backButtonSize: CGFloat = 44
    static let rightItemButtonTrailingMargin: CGFloat = 16
    static let separationViewHeight: CGFloat = 1
  }
  
  // MARK: - UI Components
  
  public let backButton = UIButton().builder
    .with {
      $0.setImage(.iconArrowLeft, for: .normal)
    }
    .build()
  
  private let categoryTagView = CategoryTagView()
  
  public let rightItemButton = UIButton().builder
    .with {
      $0.setImage(.iconMore, for: .normal)
    }
    .build()
  
  private let separationView = UIView().builder
    .backgroundColor(.black90)
    .build()
  
  // MARK: - Initialization & Deinitialization
  
  public override func initialize() {
    super.initialize()
    setupUI()
  }
  
  public override func setupConstraints() {
    super.setupConstraints()
    layout()
  }
  
  public func configure(by viewModel: CategoryNavigationBarViewMdoel) {
    categoryTagView.configure(by: viewModel.categoryViewModel)
    rightItemButton.isHidden = viewModel.isHiddenRightItem
  }
  
  private func setupUI() {
    backgroundColor = .clear
    addSubview(backButton)
    addSubview(categoryTagView)
    addSubview(rightItemButton)
    addSubview(separationView)
  }
  
  private func layout() {
    makeBackButtonCostraints()
    makeTitleLabelConstraints()
    makeRightItemButtonButtonConstraints()
    makeSeparationViewConstraints()
  }
  
  private func makeBackButtonCostraints() {
    backButton.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.backButtonLeadingMargin)
      $0.top.bottom.equalToSuperview().inset(Metric.backButtonTopBottomMargin)
    }
  }
  
  private func makeTitleLabelConstraints() {
    categoryTagView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.bottom.equalToSuperview().priority(.low)
    }
  }
  
  private func makeRightItemButtonButtonConstraints() {
    rightItemButton.snp.makeConstraints {
      $0.centerY.equalTo(backButton)
      $0.trailing.equalToSuperview().offset(-Metric.rightItemButtonTrailingMargin)
    }
  }
  
  private func makeSeparationViewConstraints() {
    separationView.snp.makeConstraints {
      $0.leading.trailing.bottom.equalToSuperview()
      $0.height.equalTo(Metric.separationViewHeight)
    }
  }
}
