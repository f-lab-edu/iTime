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
    .text("   ") // for layout
    .textColor(.white)
    .font(.systemFont(ofSize: 15, weight: .medium))
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
  
  func updateColor(with color: UIColor) {
    categoryCircleView.backgroundColor = color
  }
  
  func updateTitle(with title: String) {
    categoryTitleLabel.text = title
    layout()
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
      .right().bottom().top()
      .sizeToFit(.widthFlexible)
      .marginHorizontal(Metric.categoryCircleViewRightMargin)
  }
  
}
