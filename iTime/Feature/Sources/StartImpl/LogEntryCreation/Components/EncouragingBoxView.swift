//
//  File.swift
//
//
//  Created by 이상헌 on 11/9/23.
//

import UIKit

import SnapKit

import SharedUI
import AppFoundation

final class LoggingRetentionBoxView: BaseView {
  
  // MARK: - Constants
  
  private enum Metric {
    static let guideLabelLeadingMargin: CGFloat = 16
    static let rightAccessoryImageViewLeadingMargin: CGFloat = 16
    static let closeButtonTrailingMargin: CGFloat = 8
  }
  
  // MARK: - UI Components
  
  let guideLabel = UILabel().builder
    .text("비어있는 활동 기록을 채워보세요.")
    .font(.custom(.regular, 16))
    .textColor(.black40)
    .build()
  
  let rightAccessoryImageView = UIImageView().builder
    .image(.chevronRight)
    .build()
  
  let closeButton = UIButton().builder
    .with {
      $0.setImage(.exitCircleFill, for: .normal)
    }
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
    addSubview(guideLabel)
    addSubview(rightAccessoryImageView)
    addSubview(closeButton)
    
    backgroundColor = .black90
  }
  
  private func layout() {
    makeGuideLabelContstraints()
    makeRightAccessroyImageViewConstraints()
    makeCloseButtonConstraints()
  }
  
  private func makeGuideLabelContstraints() {
    guideLabel.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.leading.equalToSuperview().offset(Metric.guideLabelLeadingMargin)
    }
  }
  
  private func makeRightAccessroyImageViewConstraints() {
    rightAccessoryImageView.snp.makeConstraints {
      $0.leading.equalTo(guideLabel.snp.trailing).offset(Metric.rightAccessoryImageViewLeadingMargin)
      $0.centerY.equalTo(guideLabel)
      $0.size.equalTo(44)
    }
  }
  
  private func makeCloseButtonConstraints() {
    closeButton.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().offset(-Metric.closeButtonTrailingMargin)
    }
  }
}

#if DEBUG
//@available(iOS 17.0, *)
//#Preview("UIKit Portrait") {
//  print()
//}
#endif
