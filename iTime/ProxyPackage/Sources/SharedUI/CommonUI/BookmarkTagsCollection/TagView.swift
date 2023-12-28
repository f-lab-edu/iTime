//
//  File.swift
//  
//
//  Created by 이상헌 on 11/12/23.
//

import UIKit

import AppFoundation

public final class TagView: 
  BaseView,
  Configurable
{
  
  public typealias ViewModel = TagViewModel
  
  // MARK: - Constants
  
  private enum Metric {
    static let contentViewRadius: CGFloat = 16
    static let tagLabelTopBottmMargin: CGFloat = 10
    static let tagLabelLeadingTrailing: CGFloat = 20
  }
  
  // MARK: - UI Components
  
  private let tagLabel = UILabel().builder
    .text(TextType.bookmark.localizedText())
    .textColor(.black40)
    .textAlignment(.center)
    .adjustsFontForContentSizeCategory(true)
    .font(UIFontMetrics.default.scaledFont(for: .custom(.regular, 14)))
    .build()
  
  // MARK: - Initialization & Deinitialization
  
  public override func initialize() {
    super.initialize()
    setupUI()
  }
  
  public override func setupConstraints() {
    super.setupConstraints()
    layout()
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    clipsToBounds = true
    layer.cornerRadius = Metric.contentViewRadius
  }
  
  public func configure(by viewModel: TagViewModel) {
    DispatchQueue.main.async { [weak self] in
      self?.tagLabel.text = viewModel.title
      self?.backgroundColor = viewModel.backgroundColor
      self?.layer.borderWidth = viewModel.borderWidth
      self?.tagLabel.font = UIFontMetrics.default.scaledFont(for: viewModel.font)
      
      self?.remakeConstraints()
    }
  }
  
  private func setupUI() {
    backgroundColor = .clear
    layer.borderColor = UIColor.pointGreen.cgColor
    addSubview(tagLabel)
  }
  
  private func layout() {
    tagLabel.snp.makeConstraints {
      $0.center.equalToSuperview().priority(.low)
    }
  }
  
  private func remakeConstraints() {
    tagLabel.snp.remakeConstraints {
      $0.top.bottom.equalToSuperview().inset(Metric.tagLabelTopBottmMargin).priority(.high)
      $0.left.trailing.equalToSuperview().inset(Metric.tagLabelLeadingTrailing).priority(.high)
    }
    
    layoutIfNeeded()
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview {
  TagView()
}
#endif
