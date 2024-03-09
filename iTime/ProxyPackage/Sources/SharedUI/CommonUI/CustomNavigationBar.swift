//
//  File.swift
//  
//
//  Created by 이상헌 on 11/14/23.
//

import UIKit

public final class CustomNavigationBar: BaseView {
  
  // MARK: - Constants
  
  private enum Metric {
    static let backButtonLeadingMargin: CGFloat = 8
    static let backButtonTopBottomMargin: CGFloat = 4
    static let backButtonSize: CGFloat = 44
    static let addButtonTrailingMargin: CGFloat = 16
  }
  
  // MARK: - UI Components
  
  public let backButton = UIButton().builder
    .with {
      $0.setImage(.iconArrowLeft, for: .normal)
    }
    .build()
  
  private let titleLabel = UILabel().builder
    .text("즐겨찾기 설정")
    .font(.custom(.bold, 16))
    .textColor(.white)
    .build()
  
  public let rightButton = UIButton().builder
    .with {
      $0.setTitleColor(.pointGreen, for: .normal)
    }
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
  
  public func setTitleLabelAlignment(_ alignment: NSTextAlignment) {
    titleLabel.textAlignment = alignment
  }
  
  public func setRightButtonTitle(_ text: String) {
    rightButton.setTitle(text, for: .normal)
  }
  
  public func setRightButtonImage(_ image: UIImage) {
    rightButton.setImage(image, for: .normal)
  }
  
  // MARK: Layout
  
  private func setupUI() {
    backgroundColor = .clear
    addSubview(backButton)
    addSubview(titleLabel)
    addSubview(rightButton)
  }
  
  private func layout() {
    makeBackButtonCostraints()
    makeTitleLabelConstraints()
    makeAddButtonConstraints()
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
  
  private func makeAddButtonConstraints() {
    rightButton.snp.makeConstraints {
      $0.centerY.equalTo(backButton)
      $0.trailing.equalToSuperview().offset(-Metric.addButtonTrailingMargin)
    }
  }
  
}
