//
//  File.swift
//  
//
//  Created by 이상헌 on 11/12/23.
//

import UIKit

public final class TagView: 
  BaseView,
  HasConfigure
{
  
  public typealias ViewModel = String
  
  // MARK: - Constants
  
  private enum Metric {
    static let contentViewRadius: CGFloat = 16
  }
  
  // MARK: - UI Components
  
  private let tagLabel = UILabel().builder
    .text("즐겨찾기")
    .textColor(.black40)
    .textAlignment(.center)
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
  
  public func configure(by viewModel: String) {
    tagLabel.text = viewModel
    
    remakeConstraints()
  }
  
  private func setupUI() {
    backgroundColor = .black90
    addSubview(tagLabel)
  }
  
  private func layout() {
    tagLabel.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }
  
  private func remakeConstraints() {
    tagLabel.snp.remakeConstraints {
      $0.center.equalToSuperview()
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
