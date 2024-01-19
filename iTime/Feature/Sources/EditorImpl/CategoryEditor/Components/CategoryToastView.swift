//
//  File.swift
//  
//
//  Created by 이상헌 on 1/19/24.
//

import UIKit

import SharedUI

final class CategoryToastView: BaseView {
  
  // MARK: - Constants
  
  private enum Metric {
    static let titleLabelTopBottmMargin: CGFloat = 8.0
    static let titleLabelTrailingLeadingMargin: CGFloat = 16.0
    static let categoryToastViewCornerRadius: CGFloat = 8.0
  }
  
  // MARK: - UI Components
  
  private let titleLabel = UILabel().builder
    .text("카테고리 이름을 정해주세요")
    .build()
  
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
    addSubview(titleLabel)
  }
  
  private func layout() {
    backgroundColor = .black90
    layer.masksToBounds = true
    layer.cornerRadius = Metric.categoryToastViewCornerRadius
    makeTitleLabelConstraints()
  }
  
  private func makeTitleLabelConstraints() {
    titleLabel.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(Metric.titleLabelTopBottmMargin)
      $0.leading.trailing.equalToSuperview().inset(Metric.titleLabelTrailingLeadingMargin)
    }
  }
  
}
