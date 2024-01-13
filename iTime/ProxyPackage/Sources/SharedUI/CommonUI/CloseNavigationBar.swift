//
//  File.swift
//  
//
//  Created by 이상헌 on 1/4/24.
//

import UIKit

public final class CloseNavigationBar: BaseView {
  
  // MARK: - Constants
  
  private enum Metric {
    static let backButtonLeadingMargin: CGFloat = 8
    static let backButtonTopBottomMargin: CGFloat = 4
    static let backButtonSize: CGFloat = 44
    static let separationViewHeight: CGFloat = 1
  }
  
  // MARK: - UI Components
  
  public let backButton = UIButton().builder
    .with {
      $0.setImage(.iconArrowLeft, for: .normal)
    }
    .build()
  
  private let titleLabel = UILabel().builder
    .text("카테고리 설정")
    .font(.custom(.bold, 16))
    .textColor(.white)
    .build()
  
  private let separationView = UIView().builder
    .backgroundColor(.black90)
    .build()

  // MARK: - Initialization & Deinitialization
  
  public override func initialize() {
    super.initialize()
    setupUI()
  }
  
  public override func setupConstraints() {
    super.setupConstraints()
    layout()
  }
  
  // MARK: - Methods
  
  public func setTitleLabel(_ text: String) {
    titleLabel.text = text
  }
  
  // MARK: Layout
  
  private func setupUI() {
    backgroundColor = .clear
    addSubview(backButton)
    addSubview(titleLabel)
    addSubview(separationView)
  }
  
  private func layout() {
    makeBackButtonCostraints()
    makeTitleLabelConstraints()
    makeSeparationViewConstraints()
  }
  
  private func makeBackButtonCostraints() {
    backButton.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.backButtonLeadingMargin)
      $0.size.equalTo(Metric.backButtonSize)
      $0.top.bottom.equalToSuperview().inset(Metric.backButtonTopBottomMargin)
    }
  }
  
  private func makeTitleLabelConstraints() {
    titleLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
  
  private func makeSeparationViewConstraints() {
    separationView.snp.makeConstraints {
      $0.leading.trailing.bottom.equalToSuperview()
      $0.height.equalTo(Metric.separationViewHeight)
    }
  }
}
