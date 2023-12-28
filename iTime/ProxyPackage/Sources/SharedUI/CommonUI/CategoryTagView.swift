//
//  File.swift
//  
//
//  Created by 이상헌 on 12/28/23.
//

import UIKit

final class CategoryTagView:
  BaseView,
  Configurable
{
  typealias ViewModel = CategoryViewModel
  
  
  // MARK: - Constants
  
  private enum Metric {
    static let circleViewSize: CGFloat = 8
    static let circleViewInset: CGFloat = 12
    static let contentViewRadius: CGFloat = 16
    static let tagLabelTopBottmMargin: CGFloat = 10
    static let tagLabelLeadingMargin: CGFloat = 9
    static let tagLabelTrailingMargin: CGFloat = 12
  }
  
  // MARK: - UI Components
  
  private let circleView = UIView().builder
    .backgroundColor(.red)
    .with {
      $0.layer.masksToBounds = true
      $0.layer.cornerRadius = Metric.circleViewSize / 2
    }
    .build()
  
  private let tagLabel = UILabel().builder
    .text(TextType.bookmark.localizedText())
    .textColor(.black40)
    .textAlignment(.center)
    .adjustsFontForContentSizeCategory(true)
    .font(UIFontMetrics.default.scaledFont(for: .custom(.regular, 15)))
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
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    clipsToBounds = true
    layer.cornerRadius = Metric.contentViewRadius
  }
  
  func configure(by viewModel: CategoryViewModel) {
    DispatchQueue.main.async { [weak self] in
      self?.tagLabel.text = viewModel.title
      self?.circleView.backgroundColor = viewModel.color
      
      self?.remakeConstraints()
    }
  }
  
  private func setupUI() {
    backgroundColor = .black90
    addSubview(circleView)
    addSubview(tagLabel)
  }
  
  private func layout() {
    circleView.snp.makeConstraints {
      $0.centerY.equalToSuperview()
      $0.top.bottom.equalToSuperview().inset(Metric.circleViewInset).priority(.high)
      $0.leading.equalToSuperview().offset(Metric.circleViewInset)
      $0.size.equalTo(Metric.circleViewSize)
    }
    
    tagLabel.snp.makeConstraints {
      $0.leading.equalTo(circleView.snp.trailing).offset(Metric.tagLabelLeadingMargin).priority(.high)
      $0.centerY.equalToSuperview()
      $0.trailing.equalToSuperview().offset(-Metric.tagLabelTrailingMargin).priority(.high)
    }
  }
  
  private func remakeConstraints() {
    layout()
    
    layoutIfNeeded()
  }
  
}
