//
//  File.swift
//  
//
//  Created by 이상헌 on 3/7/24.
//

import UIKit

import PinLayout

import SharedUI

final class SelectedCategoryPreview: BaseView {
  
  // MARK: - Constants
  
  private enum Metric {
    static let seperatedViewHeight: CGFloat = 2.0
    static let previewLabelVerticalMargin: CGFloat = 17.0
    static let categoryDetailPreviewVerticalMargin: CGFloat = 5.0
  }
  
  // MARK: - UI Componenets
  
  private let seperatedView = UIView().builder
    .backgroundColor(.black90)
    .build()
  
  private let previewLabel = UILabel().builder
    .text("미리보기")
    .textColor(.black60)
    .font(.systemFont(ofSize: 14, weight: .regular))
    .build()
  
  private let categoryDetailPreview = CategoryDetailPreview()
  
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
    categoryDetailPreview.configure(with: viewModel)
  }
  
  private func setupUI() {
    backgroundColor = .black200
    addSubview(seperatedView)
    addSubview(previewLabel)
    addSubview(categoryDetailPreview)
  }
  
  private func layout() {
    makeSeperatedViewLayout()
    makePreviewLabelLayout()
    makeCategoryDetailPreview()
  }
  
  private func makeSeperatedViewLayout() {
    seperatedView.pin
      .top()
      .left()
      .right()
      .height(Metric.seperatedViewHeight)
  }
  
  private func makePreviewLabelLayout() {
    previewLabel.pin
      .below(of: seperatedView, aligned: .center)
      .marginVertical(Metric.previewLabelVerticalMargin)
      .hCenter()
      .sizeToFit()
  }
  
  private func makeCategoryDetailPreview() {
    categoryDetailPreview.pin
      .wrapContent()
      .below(of: previewLabel, aligned: .center)
      .marginVertical(Metric.categoryDetailPreviewVerticalMargin)
  }
  
}
