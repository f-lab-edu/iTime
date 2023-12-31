//
//  SaveBookmarkButtonSectionView.swift
//
//
//  Created by 이상헌 on 11/17/23.
//

import UIKit

import SharedUI

final class SaveBookmarkButtonSectionView: BaseView {
  
  // MARK: - Constants
  
  private enum Metric {
    static let guideLabelTopMargin: CGFloat = 12
    static let guideLabelHeight: CGFloat = 24
    static let saveButtonRadius: CGFloat = 8
    static let saveButtonTopMargin: CGFloat = 10
    static let saveButtonLeadingTrailingMargin: CGFloat = 24
    static let saveButtonHeight: CGFloat = 52
  }
  
  // MARK: - UI Components
  
  private let guideLabel = UILabel().builder
    .text(TextType.saveGuideLabel.localizedText())
    .font(.custom(.regular, 13))
    .textAlignment(.center)
    .textColor(.black60)
    .build()
  
  let saveButton = UIButton().builder
    .backgroundColor(.pointGreen)
    .set(\.layer.cornerRadius, to: Metric.saveButtonRadius)
    .with {
      $0.setTitle(TextType.save.localizedText(), for: .normal)
      $0.setTitleColor(.black20, for: .normal)
      $0.titleLabel?.font = .custom(.regular, 18)
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
      $0.top.equalToSuperview().offset(Metric.guideLabelTopMargin)
      $0.centerX.equalToSuperview()
      $0.height.equalTo(Metric.guideLabelHeight)
    }
  }
  
  private func makeSaveButtonConstraints() {
    saveButton.snp.makeConstraints {
      $0.top.equalTo(guideLabel.snp.bottom).offset(Metric.saveButtonTopMargin)
      $0.leading.trailing.bottom.equalToSuperview().inset(Metric.saveButtonLeadingTrailingMargin)
      $0.height.equalTo(Metric.saveButtonHeight)
    }
  }
}
