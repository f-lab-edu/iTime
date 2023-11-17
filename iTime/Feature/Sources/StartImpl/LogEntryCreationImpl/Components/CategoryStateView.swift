//
//  File.swift
//  
//
//  Created by 이상헌 on 11/14/23.
//

import UIKit

import SharedUI

final class CategoryStateView: 
  BaseView,
  Configurable
{
  typealias ViewModel = (color: UIColor, text: String)
  
  // MARK: - Constants
  
  private enum Metric {
    static let circleDotViewSize: CGFloat = 8
    static let circleDotViewRadius: CGFloat = 4
    static let titleLabelTrailingMargin: CGFloat = 9
  }
  
  // MARK: - UI Components
  
  private let circleDotView = UIView().builder
    .set(\.layer.cornerRadius, to: Metric.circleDotViewRadius)
    .build()
  
  private let titleLabel = UILabel()
  
  // MARK: - Initialization & Deinitialization
  
  override func initialize() {
    super.initialize()
    setupUI()
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    layout()
  }
  
  func configure(by viewModel: ViewModel) {
    circleDotView.backgroundColor = viewModel.color
    titleLabel.textColor = viewModel.color
    titleLabel.text = viewModel.text
  }
  
  private func setupUI() {
    addSubview(circleDotView)
    addSubview(titleLabel)
  }
  
  private func layout() {
    makeCircleDotViewConstraints()
    makeTitleLabelConstraints()
  }
  
  private func makeCircleDotViewConstraints() {
    circleDotView.snp.makeConstraints {
      $0.size.equalTo(Metric.circleDotViewSize)
      $0.leading.centerY.equalToSuperview()
    }
  }
  
  private func makeTitleLabelConstraints() {
    titleLabel.snp.makeConstraints {
      $0.leading.equalTo(circleDotView.snp.trailing).offset(Metric.titleLabelTrailingMargin)
      $0.top.bottom.trailing.equalToSuperview()
    }
  }
}
