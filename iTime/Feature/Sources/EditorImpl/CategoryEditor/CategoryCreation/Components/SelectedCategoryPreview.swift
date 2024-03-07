//
//  File.swift
//  
//
//  Created by 이상헌 on 3/7/24.
//

import UIKit

import PinLayout

import SharedUI
import Entities

final class SelectedCategoryPreview: BaseView {
  
  // MARK: - Constants
  
  private enum Metric {
    static let seperatedViewHeight: CGFloat = 2.0
    static let previewLabelBelowMargin: CGFloat = 17.0
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
  
  // MARK: - Initialization & Deinitialization
  
  override func initialize() {
    super.initialize()
    setupUI()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layout()
  }
  
  func setCategory(with category: Entities.Category) {
    
  }
  
  private func setupUI() {
    backgroundColor = .black200
    addSubview(seperatedView)
    addSubview(previewLabel)
  }
  
  private func layout() {
    makeSeperatedViewLayout()
    makePreviewLabelLayout()
  }
  
  private func makeSeperatedViewLayout() {
    seperatedView.pin.top().left().right().height(Metric.seperatedViewHeight)
  }
  
  private func makePreviewLabelLayout() {
    previewLabel.pin.below(of: seperatedView, aligned: .center).marginVertical(Metric.previewLabelBelowMargin).hCenter().sizeToFit()
  }
  
}
