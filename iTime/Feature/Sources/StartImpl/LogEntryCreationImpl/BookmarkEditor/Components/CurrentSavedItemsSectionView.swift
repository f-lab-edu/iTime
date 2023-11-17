//
//  File.swift
//  
//
//  Created by 이상헌 on 11/14/23.
//

import UIKit

import SharedUI

final class CurrentSavedItemsSectionView: BaseView {
  
  // MARK: - Constants
  
  private enum Metric {
    static let sectionHeaderTitleLabelLeadingMargin: CGFloat = 24
    static let sectionHeaderTitleLabelTopMargin: CGFloat = 16
    static let emptyGuideLabelTopMargin: CGFloat = 4
    static let savedItemCollectionViewTopMargin: CGFloat = 4
    static let savedItemCollectionViewBottomMargin: CGFloat = 20
  }
  
  // MARK: - UI Components
  
  private let sectionHeaderTitleLabel = UILabel().builder
    .text("현재 저장된 활동")
    .font(.custom(.bold, 16))
    .textColor(.black40)
    .build()
  
  private let emptyGuideLabel = UILabel().builder
    .text("자주 하시는 활동으로 저장해보세요!")
    .font(.custom(.regular, 12))
    .textColor(.black60)
    .build()
  
  private let savedItemCollectionView = DynamicHeightCollectionView()
  
  private lazy var adapter = BookmarkTagsCollectionViewAdapter(
    collectionView: savedItemCollectionView,
    adapterDataSource: listener,
    delegate: listener,
    alignedCollectionViewFlowLayout: LeadingAlignedCollectionViewFlowLayout()
  )
  
  // MARK: - properties
  
  private let listener: (BookmarkTagsCollectionViewAdapterDataSource & BookmarkCollectionViewCellDelegate)?
  
  // MARK: - Initialization & Deinitialization
  
  init(listener: (BookmarkTagsCollectionViewAdapterDataSource & BookmarkCollectionViewCellDelegate)?) {
    self.listener = listener
    super.init()
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
    addSubview(sectionHeaderTitleLabel)
    addSubview(emptyGuideLabel)
    addSubview(savedItemCollectionView)
    _ = adapter
  }
  
  private func layout() {
    makeSectionHeaderTitleLabelConstraints()
    makeEmptyGuideLabelConstraints()
    makeSavedItemCollectionViewConstraints()
  }
  
  private func makeSectionHeaderTitleLabelConstraints() {
    sectionHeaderTitleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.sectionHeaderTitleLabelLeadingMargin)
      $0.top.equalToSuperview().offset(Metric.sectionHeaderTitleLabelTopMargin)
    }
  }
  
  private func makeEmptyGuideLabelConstraints() {
    emptyGuideLabel.snp.makeConstraints {
      $0.leading.equalTo(sectionHeaderTitleLabel)
      $0.top.equalTo(sectionHeaderTitleLabel.snp.bottom).offset(Metric.emptyGuideLabelTopMargin)
    }
  }
  
  private func makeSavedItemCollectionViewConstraints() {
    savedItemCollectionView.snp.makeConstraints {
      $0.leading.equalTo(sectionHeaderTitleLabel)
      $0.top.equalTo(sectionHeaderTitleLabel.snp.bottom).offset(Metric.savedItemCollectionViewTopMargin)
      $0.bottom.equalToSuperview().offset(-Metric.savedItemCollectionViewBottomMargin)
    }
  }
  
}
