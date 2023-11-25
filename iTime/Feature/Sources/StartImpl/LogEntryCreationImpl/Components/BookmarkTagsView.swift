//
//  File.swift
//
//
//  Created by 이상헌 on 11/11/23.
//

import UIKit

import SharedUI

final class BookmarkTagsView: BaseView {
  
  // MARK: - Constants
  
  private enum Metric {
    static let bookmarkTagsCollectionViewTopMargin: CGFloat = 16
    static let bookmarkEditorButtonLabelTopMargin: CGFloat = 16
  }
  
  // MARK: - UI Components
  
  private let tagView = TagView().builder
    .with {
      $0.configure(by: "즐겨찾기")
    }
    .build()
  
  private lazy var bookmarkTagsCollectionView = DynamicHeightCollectionView(
    frame: .zero,
    collectionViewLayout: .init()
  ).builder
    .backgroundColor(.clear)
    .build()
  
  let bookmarkEditorButtonLabel = UILabel().builder
    .textColor(.black60)
    .with {
      let attr = NSAttributedString(
          string: "수정하기",
          attributes: [
              NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
              .font: UIFont.custom(.regular, 15),
              .foregroundColor: UIColor.black60,
          ])
      $0.attributedText = attr
    }
    .build()
  
  // MARK: - Properties
  
  private lazy var adapter = BookmarkTagsCollectionViewAdapter(
    collectionView: bookmarkTagsCollectionView,
    adapterDataSource: listener,
    delegate: listener,
    alignedCollectionViewFlowLayout: CenterAlignedCollectionViewFlowLayout()
  )
  
  private var listener: (BookmarkTagsCollectionViewAdapterDataSource & BookmarkCollectionViewCellDelegate)?
  
  // MARK: - Initialization & Deinitialization
  
  init(listener: (BookmarkTagsCollectionViewAdapterDataSource & BookmarkCollectionViewCellDelegate)?) {
    self.listener = listener
    super.init(frame: .zero)
  }
  
  override func initialize() {
    super.initialize()
    setupUI()
  }
  
  override func setupConstraints() {
    super.setupConstraints()
    layout()
  }
  
  private func setupUI() {
    addSubview(tagView)
    addSubview(bookmarkTagsCollectionView)
    addSubview(bookmarkEditorButtonLabel)
    _ = adapter // lazy var -> init() 하기 위해
    
    layout()
  }
  
  private func layout() {
    makeTagViewConstraints()
    makeBookmarkTagsCollectionViewConstraints()
    makeBookmarkEditorButtonLabelConstraints()
  }
  
  private func makeTagViewConstraints() {
    tagView.snp.makeConstraints {
      $0.top.centerX.equalToSuperview()
    }
  }
  
  private func makeBookmarkTagsCollectionViewConstraints() {
    bookmarkTagsCollectionView.snp.makeConstraints {
      $0.top.equalTo(tagView.snp.bottom).offset(Metric.bookmarkTagsCollectionViewTopMargin)
      $0.leading.trailing.equalToSuperview()
    }
  }
  
  private func makeBookmarkEditorButtonLabelConstraints() {
    bookmarkEditorButtonLabel.snp.makeConstraints {
      $0.top.equalTo(bookmarkTagsCollectionView.snp.bottom).offset(Metric.bookmarkEditorButtonLabelTopMargin)
      $0.centerX.equalToSuperview()
      $0.bottom.equalToSuperview().priority(.low)
    }
  }
  
}
