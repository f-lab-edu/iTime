//
//  File.swift
//  
//
//  Created by 이상헌 on 1/9/24.
//

import UIKit

import SharedUI

final class GuildLabelView: BaseView {
  
  // MARK: - Constants
  
  private enum Metric {
    static let GuildLabelLeadingTrailingInset: CGFloat = 16
    static let GuildLabelTopBottomInset: CGFloat = 8
  }
  
  // MARK: - UI Components
  
  private let guideLabel = UILabel().builder
    .text("카테고리 이름을 정해주세요")
    .font(.custom(.regular, 14))
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
    addSubview(guideLabel)
  }
  
  private func layout() {
    makeGuideLabelConstraints()
  }
  
  private func makeGuideLabelConstraints() {
    guideLabel.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(Metric.GuildLabelLeadingTrailingInset)
      $0.top.bottom.equalToSuperview().inset(Metric.GuildLabelTopBottomInset)
    }
  }
  
}
