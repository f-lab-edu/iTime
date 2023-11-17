//
//  SaveBookmarkButtonSectionView.swift
//
//
//  Created by 이상헌 on 11/17/23.
//

import UIKit

import SharedUI

final class View: BaseView {
  
  // MARK: - Constants
  
  private enum Metric {
    static let saveButtonRadius: CGFloat = 8
    static let saveButtonTopMargin: CGFloat = 10
    static let saveButtonLeadingTrailingMargin: CGFloat = 24
  }
  
  // MARK: - UI Components
  
  private let guideLabel = UILabel().builder
    .text("즐겨찾기는 각 활동 상세화면에서도 추가할 수 있어요")
    .textAlignment(.center)
    .textColor(.black60)
    .build()
  
  private let saveButton = UIButton().builder
    .set(\.layer.cornerRadius, to: Metric.saveButtonRadius)
    .with {
      $0.setTitle("저장", for: .normal)
      $0.setTitleColor(.black20, for: .normal)
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
    addSubview(saveButton)
  }
  
  private func layout() {
    makeGuideLabelConstraints()
    makeSaveButtonConstraints()
  }
  
  private func makeGuideLabelConstraints() {
    guideLabel.snp.makeConstraints {
      $0.top.centerX.equalToSuperview()
    }
  }
  
  private func makeSaveButtonConstraints() {
    saveButton.snp.makeConstraints {
      $0.top.equalTo(guideLabel).offset(Metric.saveButtonTopMargin)
      $0.leading.trailing.bottom.equalToSuperview().inset(Metric.saveButtonLeadingTrailingMargin)
    }
  }
}
