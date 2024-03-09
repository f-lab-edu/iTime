//
//  File.swift
//
//
//  Created by 이상헌 on 3/9/24.
//

import UIKit

import SharedUI

final class CategoryDeletionButton: UIButton {
  
  // MARK: - Constants
  
  private enum Metric {
    static let deletionImageViewSize: CGFloat = 24.0
    static let deletionImageViewLeftMargin: CGFloat = 12.0
    static let deletionImageViewVerticalMargin: CGFloat = 8.0
  }
  
  // MARK: - UI Components
  
  private let deletionImageView = UIImageView().builder
    .image(.delete)
    .build()
  
  private let deletionTitleLabel = UILabel().builder
    .text("카테고리 삭제")
    .font(.custom(.regular, 14))
    .textColor(.white)
    .build()
  
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
  
  private func setupUI() {
    backgroundColor = .black90
    addSubview(deletionImageView)
    addSubview(deletionTitleLabel)
  }
  
  private func layout() {
    makeDeletionImageViewLayout()
    makeDeletionTitleLabelLayout()
  }
  
  private func makeDeletionImageViewLayout() {
    deletionImageView.pin
      .left(Metric.deletionImageViewLeftMargin)
      .vertically(Metric.deletionImageViewVerticalMargin)
      .size(Metric.deletionImageViewSize)
  }
  
  private func makeDeletionTitleLabelLayout() {
    deletionTitleLabel.pin
      .left(to: deletionImageView.edge.right)
      .right()
      .vCenter(to: deletionImageView.edge.vCenter)
      .sizeToFit(.width)
      .marginLeft(7)
      .marginRight(12)
  }
}
