//
//  File.swift
//
//
//  Created by 이상헌 on 11/10/23.
//

import UIKit

import SnapKit

public protocol BookmarkCollectionViewCellDelegate: AnyObject {
  func didTap()
}

final class BookmarkTagCell:
  BaseCollectionViewCell,
  HasConfigure
{
  
  // MARK: - Properties
  
  typealias ViewModel = String
  
  // MARK: - UI Components
  
  private lazy var tagLabel = UILabel().builder
    .text("tagLabel")
    .textAlignment(.center)
    .build()
  
  // MARK: Initialization
  
  override func initialize() {
    super.initialize()
    setupUI()
  }
  
  override func updateConstraints() {
    super.updateConstraints()
    layout()
  }
  
  // MARK: - Internal methods
  
  func configure(by viewModel: String) {
    tagLabel.text = viewModel
  }
  
  // MARK: - Private methods
  
  private func initUI() {
    tagLabel.text = nil
  }
  
}

// MARK: - Layout

extension BookmarkTagCell {
  private func setupUI() {
    contentView.layer.cornerRadius = 6
    contentView.addSubview(tagLabel)
    
    initUI()
  }
  
  private func layout() {
    tagLabel.snp.makeConstraints {
      $0.left.right.equalToSuperview().inset(6)
      $0.top.bottom.equalToSuperview().inset(4)
    }
  }
}


#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  BookmarkTagCell()
}
#endif
