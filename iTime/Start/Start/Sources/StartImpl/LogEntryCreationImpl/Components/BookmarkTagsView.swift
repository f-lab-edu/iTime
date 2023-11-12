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
    static let tagViewHeight: CGFloat = 36
    static let tagViewWidth: CGFloat = 82
    static let bookmarkTagsCollectionViewTopMargin: CGFloat = 16
    static let bookmarkEditorButtonLabelTopMargin: CGFloat = 16
  }
  
  // MARK: - UI Components
  
  private let tagView = TagView()
  
  private lazy var bookmarkTagsCollectionView = DynamicHeightCollectionView(
    frame: .zero,
    collectionViewLayout: .init()
  ).builder
    .backgroundColor(.clear)
    .build()
  
  private let bookmarkEditorButtonLabel = UILabel().builder
    .textColor(.black60)
    .with {
      let attr = NSAttributedString(
          string: "수정하기",
          attributes: [
              NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
              .font: UIFont.systemFont(ofSize: 14),
              .foregroundColor: UIColor.black40,
          ])
      $0.attributedText = attr
    }
    .text("수정하기")
    .build()
  
  // MARK: - Properties
  
  private lazy var adapter = BookmarkTagsCollectionViewAdapter(
    collectionView: bookmarkTagsCollectionView,
    adapterDataSource: listener,
    delegate: listener
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
      $0.width.equalTo(Metric.tagViewWidth)
      $0.height.equalTo(Metric.tagViewHeight)
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
