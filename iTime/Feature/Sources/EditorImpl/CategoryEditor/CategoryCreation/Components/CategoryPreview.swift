//
//  File.swift
//  
//
//  Created by 이상헌 on 3/7/24.
//

import UIKit

import SharedUI

final class CategoryPreview: BaseView {
  
  // MARK: - Constants
  
  private enum Metric {
    static let categoryCircleViewRightMargin: CGFloat = 9.0
    static let categoryCircleViewSize: CGFloat = 8.0
  }
  
  // MARK: - UI Components
  
  private let categoryCircleView = UIView()
  
  private let categoryTitleLabel = UILabel()
  
  // MARK: - Initialization & Deinitialization
  
  override func initialize() {
    super.initialize()
    setupUI()
  }
  
  override func setupConstraints() {
    super.setupConstraints()
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
    categoryCircleView.pin.size(Metric.categoryCircleViewSize)
  }
  
  private func makeCategoryTitleLabel() {
    
  }
  
}
