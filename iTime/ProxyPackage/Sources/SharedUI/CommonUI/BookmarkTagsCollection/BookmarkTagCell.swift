//
//  File.swift
//
//
//  Created by 이상헌 on 11/10/23.
//

import UIKit

import SnapKit

public final class BookmarkTagCell:
  BaseCollectionViewCell,
  Configurable
{
  
  // MARK: - Constants
  
  private enum Metric {
    static let contentViewRadius: CGFloat = 16
  }
  
  // MARK: - Properties
  
  public typealias ViewModel = BookmarkCollectionCellViewModel
  
  // MARK: - UI Components
  
  private let tagLabel = UILabel().builder
    .font(.custom(.regular, 16))
    .textColor(.black60)
    .textAlignment(.center)
    .build()
  
  // MARK: Initialization
  
  override func initialize() {
    super.initialize()
    setupUI()
  }
  
  public override func updateConstraints() {
    super.updateConstraints()
    layout()
  }
  
  public override func layerWillDraw(_ layer: CALayer) {
    super.layerWillDraw(layer)
  }
  
  // MARK: - Internal methods
  
  public func configure(by viewModel: BookmarkCollectionCellViewModel) {
    tagLabel.text = viewModel.title
    contentView.clipsToBounds = true
    contentView.applyRoundedCorners(
      Metric.contentViewRadius,
      widthBorder: 1,
      borderColor: viewModel.borderColor
    )
  }
  
  // MARK: - Private methods
  
  private func initUI() {
    tagLabel.text = nil
  }
  
}

// MARK: - Layout

extension BookmarkTagCell {
  private func setupUI() {
    contentView.addSubview(tagLabel)
  }
  
  private func layout() {
    tagLabel.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(6)
      $0.leading.trailing.equalToSuperview().inset(16)
    }
  }
}


#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  BookmarkTagCell()
}
#endif
