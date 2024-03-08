//
//  File.swift
//  
//
//  Created by 이상헌 on 1/5/24.
//

import UIKit

import SharedUI

final class CategoryListCell: BaseTableViewCell {
  
  // MARK: - Constants
  
  private enum Metric {
    static let circleViewSize: CGFloat = 12
    static let circleViewInset: CGFloat = 12
    static let editButtonSize: CGFloat = 20
    static let editButtonInset: CGFloat = 12
    static let separationViewHeight: CGFloat = 1
  }
  
  // MARK: - UI Components
  
  private let circleView = UIView().builder
    .set(\.layer.masksToBounds, to: true)
    .set(\.layer.cornerRadius, to: Metric.circleViewSize / 2)
    .build()
  
  private let titleLabel = UILabel().builder
    .text("자기개발")
    .build()
  
  private let editButton = UIButton().builder
    .with {
      $0.setImage(.edit, for: .normal)
    }
    .build()
  
  private let separationView = UIView().builder
    .backgroundColor(.black90)
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
  
  func configure(_ viewModel: CategoryViewModel) {
    circleView.backgroundColor = viewModel.color
    titleLabel.text = viewModel.title
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    circleView.backgroundColor = .clear
    titleLabel.text = ""
  }
  
  private func setupUI() {
    backgroundColor = .clear
    contentView.addSubview(circleView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(editButton)
    contentView.addSubview(separationView)
  }
  
  private func layout() {
    makeCircleViewContstraints()
    makeTitleLabelConstraints()
    makeEditButtonConstraints()
    makeSeparationViewConstraints()
  }
  
  private func makeCircleViewContstraints() {
    circleView.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(Metric.circleViewInset)
      $0.centerY.equalToSuperview()
      $0.size.equalTo(Metric.circleViewSize)
    }
  }
  
  private func makeTitleLabelConstraints() {
    titleLabel.snp.makeConstraints {
      $0.leading.equalTo(circleView.snp.trailing).offset(Metric.circleViewInset)
      $0.centerY.equalTo(circleView)
    }
  }
  
  private func makeEditButtonConstraints() {
    editButton.snp.makeConstraints {
      $0.trailing.equalToSuperview().inset(Metric.editButtonInset)
      $0.centerY.equalToSuperview()
      $0.size.equalTo(Metric.editButtonSize)
    }
  }
  
  private func makeSeparationViewConstraints() {
    separationView.snp.makeConstraints {
      $0.height.equalTo(Metric.separationViewHeight)
      $0.leading.equalTo(circleView)
      $0.trailing.equalTo(editButton)
      $0.bottom.equalToSuperview()
    }
  }
  
}
