//
//  File.swift
//
//
//  Created by 이상헌 on 11/26/23.
//

import UIKit

import SharedUI

final class DatePickerSectionView: BaseView {
  
  // MARK: - Constants
  
  private enum Metric {
    static let buttonRadius: CGFloat = 8
    static let buttonHeight: CGFloat = 44
    static let buttonWidth: CGFloat = 70
    static let buttonTopMargin: CGFloat = 4
    static let eachButtonMargin: CGFloat = 6
    static let buttonSectionMargin: CGFloat = 20
    static let separationViewHeight: CGFloat = 4
  }
  
  // MARK: - UI Components
  
  private let startTitleLabel = UILabel().builder
    .text("시작")
    .textColor(.black60)
    .font(.custom(.regular, 14))
    .build()
  
  private let startMonthAndDayButton = UIButton().builder
    .backgroundColor(.black100)
    .with {
      $0.setTitle("10/10", for: .normal)
      $0.setTitleColor(.black40, for: .normal)
      $0.titleLabel?.font = .custom(.regular, 20)
    }
    .set(\.layer.cornerRadius, to: Metric.buttonRadius)
    .build()
  
  private let startHourAndMinuteButton = UIButton().builder
    .backgroundColor(.black100)
    .with {
      $0.setTitle("10/10", for: .normal)
      $0.setTitleColor(.black40, for: .normal)
      $0.titleLabel?.font = .custom(.regular, 20)
    }
    .set(\.layer.cornerRadius, to: Metric.buttonRadius)
    .build()
  
  private let separationView = UIView()
  
  private let endTitleLabel = UILabel().builder
    .text("종료")
    .textColor(.black60)
    .font(.custom(.regular, 14))
    .build()
  
  private let endMonthAndDayButton = UIButton().builder
    .backgroundColor(.black100)
    .with {
      $0.setTitle("10 : 19", for: .normal)
      $0.setTitleColor(.black80, for: .normal)
      $0.titleLabel?.font = .custom(.regular, 20)
    }
    .set(\.layer.cornerRadius, to: Metric.buttonRadius)
    .build()
  
  private let endHourAndMinuteButton = UIButton().builder
    .backgroundColor(.black100)
    .with {
      $0.setTitle("10/10", for: .normal)
      $0.setTitleColor(.black80, for: .normal)
      $0.titleLabel?.font = .custom(.regular, 20)
    }
    .set(\.layer.cornerRadius, to: Metric.buttonRadius)
    .build()
  
  // MARK: - Private
  
  func drawDotLine() {
    let layer = CAShapeLayer()
    layer.strokeColor = UIColor.pointGreen.cgColor
    layer.lineDashPattern = [2, 2]
    
    let path = UIBezierPath()
    let point1 = CGPoint(x: separationView.bounds.minX + 2, y: separationView.bounds.midY)
    let point2 = CGPoint(x: separationView.bounds.maxX - 2, y: separationView.bounds.midY)
    
    path.move(to: point1)
    path.addLine(to: point2)
    
    layer.path = path.cgPath
    separationView.layer.addSublayer(layer)
  }
  
  // MARK: - Initialization & Deinitialization
  
  override func initialize() {
    super.initialize()
    setupUI()
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    layout()
  }
  
  override func draw(_ rect: CGRect) {
    super.draw(rect)
    drawDotLine()
  }
  
  private func setupUI() {
    addSubview(startTitleLabel)
    addSubview(startMonthAndDayButton)
    addSubview(startHourAndMinuteButton)
    addSubview(endTitleLabel)
    addSubview(separationView)
    addSubview(endMonthAndDayButton)
    addSubview(endHourAndMinuteButton)
  }
  
  private func layout() {
    makeStartTitleLabelConstraints()
    makeStartMonthAndDayButtonConstraints()
    makeStartHourAndMinuteButtonConstraints()
    makeSeparationViewConstraints()
    makeEndTitleLabelConstraints()
    makeEndMonthAndDayButtonConstraints()
    makeEndHourAndMinuteButtonConstraints()
  }
  
  private func makeStartTitleLabelConstraints() {
    startTitleLabel.snp.makeConstraints {
      $0.top.leading.equalToSuperview()
    }
  }
  
  private func makeStartMonthAndDayButtonConstraints() {
    startMonthAndDayButton.snp.makeConstraints {
      $0.top.equalTo(startTitleLabel.snp.bottom).offset(Metric.buttonTopMargin)
      $0.leading.bottom.equalToSuperview()
      $0.width.equalTo(Metric.buttonWidth)
      $0.height.equalTo(Metric.buttonHeight)
    }
  }
  
  private func makeStartHourAndMinuteButtonConstraints() {
    startHourAndMinuteButton.snp.makeConstraints {
      $0.top.bottom.equalTo(startMonthAndDayButton)
      $0.leading.equalTo(startMonthAndDayButton.snp.trailing).offset(Metric.eachButtonMargin)
      $0.size.equalTo(startMonthAndDayButton)
    }
  }
  
  private func makeSeparationViewConstraints() {
    separationView.snp.makeConstraints {
      $0.height.equalTo(Metric.separationViewHeight)
      $0.leading.equalTo(startHourAndMinuteButton.snp.trailing)
      $0.trailing.equalTo(endMonthAndDayButton.snp.leading)
      $0.centerY.equalTo(startMonthAndDayButton)
    }
  }
  
  private func makeEndTitleLabelConstraints() {
    endTitleLabel.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.equalTo(endMonthAndDayButton)
    }
  }
  
  private func makeEndMonthAndDayButtonConstraints() {
    endMonthAndDayButton.snp.makeConstraints {
      $0.top.bottom.equalTo(startMonthAndDayButton)
      $0.leading.equalTo(startHourAndMinuteButton.snp.trailing).offset(Metric.buttonSectionMargin).priority(.high)
      $0.size.equalTo(startMonthAndDayButton)
    }
  }
  
  private func makeEndHourAndMinuteButtonConstraints() {
    endHourAndMinuteButton.snp.makeConstraints {
      $0.top.bottom.equalTo(startMonthAndDayButton)
      $0.trailing.equalToSuperview()
      $0.leading.equalTo(endMonthAndDayButton.snp.trailing).offset(Metric.eachButtonMargin)
      $0.size.equalTo(startMonthAndDayButton)
    }
  }
  
}
