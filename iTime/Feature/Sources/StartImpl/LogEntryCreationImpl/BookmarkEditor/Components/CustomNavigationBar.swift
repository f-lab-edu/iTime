//
//  File.swift
//  
//
//  Created by 이상헌 on 11/14/23.
//

import UIKit

import SharedUI

final class CustomNavigationBar: BaseView {
  
  // MARK: - Constants
  
  private enum Metric {
    static let backButtonLeadingMargin: CGFloat = 8
    static let backButtonTopBottomMargin: CGFloat = 4
    static let backButtonSize: CGFloat = 44
  }
  
  // MARK: - UI Components
  
  private let backButton = UIButton().builder
    .with {
      $0.setImage(.remove, for: .normal)
    }
    .build()
  
  private let titleLabel = UILabel().builder
    .text("즐겨찾기 설정")
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
  
  private func setupUI() {
    backgroundColor = .clear
    addSubview(backButton)
    addSubview(titleLabel)
  }
  
  private func layout() {
    makeBackButtonCostraints()
    makeTitleLabelConstraints()
  }
  
  private func makeBackButtonCostraints() {
    backButton.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.backButtonLeadingMargin)
      $0.top.bottom.equalToSuperview().inset(Metric.backButtonTopBottomMargin)
    }
  }
  
  private func makeTitleLabelConstraints() {
    titleLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
  
}
