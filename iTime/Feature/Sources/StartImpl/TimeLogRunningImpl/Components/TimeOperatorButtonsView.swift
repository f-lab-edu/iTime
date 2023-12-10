//
//  File.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import UIKit

import SharedUI

final class TimeOperatorButtonsView: BaseView {
  
  // MARK: - Constants
  
  private enum Metric {
    static let buttonsWidth: CGFloat = 85
    static let buttonsHeight: CGFloat = 48
    static let stopButtonLeadingMargin: CGFloat = 16
    static let buttonRadius: CGFloat = 8
  }
  
  // MARK: - UI Components
  
  private let startButton = UIButton().builder
    .with {
      $0.setImage(.start, for: .normal)
      $0.backgroundColor = .black80
      $0.layer.cornerRadius = Metric.buttonRadius
    }
    .build()
  
  private let pauseButton = UIButton().builder
    .with {
      $0.setImage(.pause, for: .normal)
      $0.backgroundColor = .black80
      $0.layer.cornerRadius = Metric.buttonRadius
    }
    .build()
  
  private let endButton = UIButton().builder
    .with {
      $0.setImage(.stop, for: .normal)
      $0.backgroundColor = .pointGreen
      $0.layer.cornerRadius = Metric.buttonRadius
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
    addSubview(startButton)
    addSubview(pauseButton)
    addSubview(endButton)
  }
  
  private func layout() {
    makeStartButtonConstraints()
    makePauseButtonConstraints()
    makeEndButtonConstraints()
  }
  
  private func makeStartButtonConstraints() {
    startButton.snp.makeConstraints {
      $0.width.equalTo(Metric.buttonsWidth)
      $0.height.equalTo(Metric.buttonsHeight)
      $0.leading.top.bottom.equalToSuperview()
    }
  }
  
  private func makePauseButtonConstraints() {
    pauseButton.snp.makeConstraints {
      $0.edges.equalTo(startButton)
    }
  }
  
  private func makeEndButtonConstraints() {
    endButton.snp.makeConstraints {
      $0.width.height.equalTo(startButton)
      $0.leading.equalTo(startButton.snp.trailing).offset(Metric.stopButtonLeadingMargin)
      $0.trailing.top.bottom.equalToSuperview()
    }
  }
  
}
