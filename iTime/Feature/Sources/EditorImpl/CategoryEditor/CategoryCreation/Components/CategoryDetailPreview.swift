//
//  File.swift
//  
//
//  Created by 이상헌 on 3/7/24.
//

import UIKit

import SharedUI

final class CategoryDetailPreview: BaseView {
  
  // MARK: - Constants
  
  private enum Metric {
    static let categoryCircleViewRightMargin: CGFloat = 9.0
    static let categoryCircleViewSize: CGFloat = 8.0
  }
  
  // MARK: - UI Components
  
  private let categoryCircleView = UIView().builder
    .backgroundColor(.red)
    .set(\.layer.masksToBounds, to: true)
    .set(\.layer.cornerRadius, to: Metric.categoryCircleViewSize / 2)
    .build()
  
  private let categoryTitleLabel = UILabel().builder
    .text("아리가또")
    .textColor(.yellow)
    .build()
  
  // MARK: - Initialization & Deinitialization
  
  override func initialize() {
    super.initialize()
    setupUI()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layout()
  }
  
  func configure(with viewModel: CategoryViewModel) {
    categoryCircleView.backgroundColor = viewModel.color
    categoryTitleLabel.text = viewModel.title
  }
  
  private func setupUI() {
    addSubview(categoryCircleView)
    addSubview(categoryTitleLabel)
  }
  
  private func layout() {
    makeCategoryCircleLayout()
    makeCategoryTitleLabel()
  }
  
  private func makeCategoryCircleLayout() {
    categoryCircleView.pin
      .left()
      .vCenter()
      .size(Metric.categoryCircleViewSize)
  }
  
  private func makeCategoryTitleLabel() {
    categoryTitleLabel.pin
      .after(of: categoryCircleView)
      .marginHorizontal(Metric.categoryCircleViewRightMargin)
      .sizeToFit()
  }
  
}
