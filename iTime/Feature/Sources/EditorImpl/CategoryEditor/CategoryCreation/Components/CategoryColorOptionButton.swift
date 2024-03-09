//
//  File.swift
//
//
//  Created by 이상헌 on 3/8/24.
//

import UIKit

import SharedUI

final class CategoryColorOptionButton: UIButton {
  
  // MARK: - Constants
  
  private enum Metric {
    static let circleViewSize: CGFloat = 24.0
    static let borderViewSize: CGFloat = 42.0
    static let allMargin: CGFloat = 10.0
  }
  
  // MARK: - UI Components
  
  private lazy var circleView = UIView().builder
    .isUserInteractionEnabled(false)
    .build()
  
  private lazy var borderView = UIView().builder
    .isUserInteractionEnabled(false)
    .isHidden(true)
    .build()
  
  private var circleLayer: CALayer {
    let layer = CAShapeLayer()
    layer.path = UIBezierPath(ovalIn: circleView.bounds).cgPath
    return layer
  }
  
  private var borderLayer: CALayer {
    let layer = CAShapeLayer()
    layer.path = UIBezierPath(
      roundedRect: borderView.bounds.insetBy(dx: 5, dy: 5),
      cornerRadius: borderView.bounds.height / 2
    ).cgPath
    layer.fillColor = UIColor.clear.cgColor
    layer.strokeColor = UIColor.red.cgColor
    return layer
  }
  
  // MARK: - Initialization & Deinitialization
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    layout()
  }
  
  override var isSelected: Bool {
    didSet {
      setSelectedState(isSelected)
    }
  }
  
  private func setSelectedState(_ isSelected: Bool) {
    borderView.isHidden = !isSelected
  }
  
  func configureButtonColor(with color: UIColor) {
    borderView.backgroundColor = color
    circleView.backgroundColor = color
  }
  
  private func setupUI() {
    addSubview(circleView)
    addSubview(borderView)
  }
  
  private func layout() {
    makeBoarderViewLayout()
    makeCircleViewLayout()
    setLayers()
  }
  
  private func setLayers() {
    circleView.layer.mask = circleLayer
    borderView.layer.mask = borderLayer
  }
  
  private func makeBoarderViewLayout() {
    borderView.pin
      .size(CGSize(width: Metric.borderViewSize, height: Metric.borderViewSize))
      .all()
  }
  
  private func makeCircleViewLayout() {
    circleView.pin
      .size(CGSize(width: Metric.circleViewSize, height: Metric.circleViewSize))
      .center(to: borderView.anchor.center)
  }
}
