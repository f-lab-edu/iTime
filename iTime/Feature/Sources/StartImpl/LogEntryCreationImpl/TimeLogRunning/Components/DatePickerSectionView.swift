//
//  File.swift
//
//
//  Created by 이상헌 on 11/26/23.
//

import UIKit

import RxSwift

import AppFoundation
import SharedUI

final class DatePickerSectionView:
  BaseView,
  EndEditingDelegate
{
  
  // MARK: - Constants
  
  private enum Metric {
    static let textFieldRadius: CGFloat = 8
    static let textFieldHeight: CGFloat = 44
    static let textFieldWidth: CGFloat = 70
    static let textFieldTopMargin: CGFloat = 4
    static let eachTextFieldMargin: CGFloat = 6
    static let textFieldSectionMargin: CGFloat = 20
    static let separationViewHeight: CGFloat = 4
  }
  
  // MARK: - UI Components
  
  private let startTitleLabel = UILabel().builder
    .text("시작")
    .textColor(.black60)
    .font(.custom(.regular, 14))
    .build()
  
  private lazy var startDateTextField = UITextField().builder
    .backgroundColor(.black100)
    .text("10/10")
    .textColor(.black40)
    .font(.custom(.regular, 20))
    .textAlignment(.center)
    .with { [weak self] textField in
      self?.datePickerFactory.makeStartDateToolBar(textField)
    }
    .set(\.layer.cornerRadius, to: Metric.textFieldRadius)
    .build()
  
  private lazy var startTimeTextField = UITextField().builder
    .backgroundColor(.black100)
    .text("10/10")
    .textColor(.black40)
    .font(.custom(.regular, 20))
    .textAlignment(.center)
    .with { [weak self] textField in
      self?.datePickerFactory.makeStartTimeToolbar(textField)
    }
    .set(\.layer.cornerRadius, to: Metric.textFieldRadius)
    .build()
  
  private let separationView = UIView()
  
  private let endTitleLabel = UILabel().builder
    .text("종료")
    .textColor(.black60)
    .font(.custom(.regular, 14))
    .build()
  
  private lazy var endDateTextField = UITextField().builder
    .backgroundColor(.black100)
    .text("10/10")
    .font(.custom(.regular, 20))
    .textColor(.black80)
    .textAlignment(.center)
    .with { [weak self] textField in
      self?.datePickerFactory.makeEndDateToolBar(textField)
    }
    .set(\.layer.cornerRadius, to: Metric.textFieldRadius)
    .build()
  
  private lazy var endTimeTextField = UITextField().builder
    .backgroundColor(.black100)
    .text("10/10")
    .textColor(.black80)
    .font(.custom(.regular, 20))
    .textAlignment(.center)
    .with { [weak self] textField in
      self?.datePickerFactory.makeEndTimeToolbar(textField)
    }
    .set(\.layer.cornerRadius, to: Metric.textFieldRadius)
    .build()
  
  // MARK: - Properties
  
  private let timeFormatter: TimeFormatter
  private lazy var datePickerFactory = DatePickerFactory(timeFormatter: timeFormatter)
  
  // MARK: - Initialization & Deinitialization
  
  init(timeFormatter: TimeFormatter) {
    self.timeFormatter = timeFormatter
    super.init(frame: .zero)
    datePickerFactory.delegate = self
  }
  
  override func initialize() {
    super.initialize()
    setupUI()
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    layout()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    drawDotLine()
  }
  
  // MARK: - Private
  
  private func drawDotLine() {
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
  
  // MARK: - Delegate
  
  func endEditing() {
    endEditing(true)
  }
  
  // MARK: - Layout
  
  private func setupUI() {
    addSubview(startTitleLabel)
    addSubview(startDateTextField)
    addSubview(startTimeTextField)
    addSubview(endTitleLabel)
    addSubview(separationView)
    addSubview(endDateTextField)
    addSubview(endTimeTextField)
  }
  
  private func layout() {
    makeStartTitleLabelConstraints()
    makeStartDateTextFieldConstraints()
    makeStartTimeTextFieldConstraints()
    makeSeparationViewConstraints()
    makeEndTitleLabelConstraints()
    makeEndDateTextFieldConstraints()
    makeEndTimeTextFieldConstraints()
  }
  
  private func makeStartTitleLabelConstraints() {
    startTitleLabel.snp.makeConstraints {
      $0.top.leading.equalToSuperview()
    }
  }
  
  private func makeStartDateTextFieldConstraints() {
    startDateTextField.snp.makeConstraints {
      $0.top.equalTo(startTitleLabel.snp.bottom).offset(Metric.textFieldTopMargin)
      $0.leading.bottom.equalToSuperview()
      $0.width.equalTo(Metric.textFieldWidth)
      $0.height.equalTo(Metric.textFieldHeight)
    }
  }
  
  private func makeStartTimeTextFieldConstraints() {
    startTimeTextField.snp.makeConstraints {
      $0.top.bottom.equalTo(startDateTextField)
      $0.leading.equalTo(startDateTextField.snp.trailing).offset(Metric.eachTextFieldMargin)
      $0.size.equalTo(startDateTextField)
    }
  }
  
  private func makeSeparationViewConstraints() {
    separationView.snp.makeConstraints {
      $0.height.equalTo(Metric.separationViewHeight)
      $0.leading.equalTo(startTimeTextField.snp.trailing)
      $0.trailing.equalTo(endDateTextField.snp.leading)
      $0.centerY.equalTo(startDateTextField)
    }
  }
  
  private func makeEndTitleLabelConstraints() {
    endTitleLabel.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.equalTo(endDateTextField)
    }
  }
  
  private func makeEndDateTextFieldConstraints() {
    endDateTextField.snp.makeConstraints {
      $0.top.bottom.equalTo(startDateTextField)
      $0.leading.equalTo(startTimeTextField.snp.trailing).offset(Metric.textFieldSectionMargin).priority(.high)
      $0.size.equalTo(startDateTextField)
    }
  }
  
  private func makeEndTimeTextFieldConstraints() {
    endTimeTextField.snp.makeConstraints {
      $0.top.bottom.equalTo(startDateTextField)
      $0.trailing.equalToSuperview()
      $0.leading.equalTo(endDateTextField.snp.trailing).offset(Metric.eachTextFieldMargin)
      $0.size.equalTo(startDateTextField)
    }
  }
  
}

