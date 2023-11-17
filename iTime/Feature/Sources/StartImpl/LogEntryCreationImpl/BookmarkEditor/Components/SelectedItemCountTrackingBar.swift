//
//  File.swift
//  
//
//  Created by 이상헌 on 11/14/23.
//

import UIKit

import SharedUI

final class SelectedItemCountTrackingBar:
  BaseView,
  HasConfigure
{
  typealias ViewModel = (text: String, textColor: UIColor, backgroundColor: UIColor)
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - UI Components
  
  private let titleLabel = UILabel().builder
    .text("0/6")
    .textColor(.white)
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
  
  func configure(by viewModel: ViewModel) {
    titleLabel.text = viewModel.text
    titleLabel.textColor = viewModel.textColor
    backgroundColor = viewModel.backgroundColor
  }
  
  private func setupUI() {
    backgroundColor = .black90
    addSubview(titleLabel)
  }
  
  private func layout() {
    makeTitleLabelConstraints()
  }

  private func makeTitleLabelConstraints() {
    titleLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
  
}
