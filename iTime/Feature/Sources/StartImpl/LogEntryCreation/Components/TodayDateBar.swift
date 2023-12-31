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

final class TodayDateBar: BaseView {
  
  // MARK: - Constants
  
  private enum Metric {
    static let trailingLeadingMargin: CGFloat = 16
    static let dateLableLeadingMargin: CGFloat = 16
  }
  
  // MARK: - UI Components
  
  private let largeTitle = UILabel().builder
    .text("TODAY")
    .font(.custom(.medium, 22))
    .textColor(.white)
    .build()
  
  private let dateLabel = UILabel().builder
    .text("10월 10일, 화요일") // FIXME: need to fix
    .font(.custom(.bold, 16))
    .textColor(.pointGreen)
    .build()
  
  let settingButton = UIButton().builder
    .with {
      $0.setImage(.gearFill, for: .normal)
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
  
  // MARK: - Layout
  
  private func setupUI() {
    addSubview(largeTitle)
    addSubview(dateLabel)
    addSubview(settingButton)
  }
  
  private func layout() {
    makeLargeTitleConstraints()
    makeDateLabelContstraints()
    makeSettingButtonConstraints()
  }
  
  private func makeLargeTitleConstraints() {
    largeTitle.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.trailingLeadingMargin)
      $0.centerY.equalToSuperview()
    }
  }
  
  private func makeDateLabelContstraints() {
    dateLabel.snp.makeConstraints {
      $0.leading.equalTo(largeTitle.snp.trailing).offset(Metric.dateLableLeadingMargin)
      $0.centerY.equalTo(largeTitle)
    }
  }
  
  private func makeSettingButtonConstraints() {
    settingButton.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(4)
      $0.trailing.equalToSuperview().offset(-Metric.trailingLeadingMargin)
    }
  }
}
