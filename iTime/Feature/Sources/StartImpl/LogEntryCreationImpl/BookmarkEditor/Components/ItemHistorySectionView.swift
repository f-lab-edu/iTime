//
//  itemHistorySectionView.swift
//
//
//  Created by 이상헌 on 11/17/23.
//

import UIKit

import SharedUI

final class ItemHistorySectionView: BaseView {
  
  // MARK: - Constants
  
  private enum Metric {
    static let sectionHeaderTitleLabelLeadingMargin: CGFloat = 24
    static let sectionHeaderTitleLabelTopMargin: CGFloat = 16
    static let guideLabelTopMargin: CGFloat = 4
    static let itemHistoryCollectionViewTopMargin: CGFloat = 4
    static let itemHistoryCollectionViewBottomMargin: CGFloat = 20
  }
  
  // MARK: - UI Components
  
  private let sectionHeaderTitleLabel = UILabel().builder
    .text("현재 기록")
    .font(.systemFont(ofSize: 16, weight: .bold))
    .textColor(.black40)
    .build()
  
  private let guideLabel = UILabel().builder
    .text("자주 했던 활동을 모아 보았어요")
    .textColor(.black60)
    .build()
  
  private let ItemHistoryCollectionView = DynamicHeightCollectionView()
  
  private lazy var adapter = BookmarkTagsCollectionViewAdapter(
    collectionView: ItemHistoryCollectionView,
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
    addSubview(guideLabel)
    addSubview(ItemHistoryCollectionView)
  }
  
  private func layout() {
    makeSectionHeaderTitleLabelConstraints()
    makeSectionGuideLabelConstraints()
    makeItemHistoryCollectionViewConstraints()
  }
  
  private func makeSectionHeaderTitleLabelConstraints() {
    sectionHeaderTitleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.sectionHeaderTitleLabelLeadingMargin)
      $0.top.equalToSuperview().offset(Metric.sectionHeaderTitleLabelTopMargin)
    }
  }
  
  private func makeSectionGuideLabelConstraints() {
    guideLabel.snp.makeConstraints {
      $0.leading.equalTo(sectionHeaderTitleLabel)
      $0.top.equalTo(sectionHeaderTitleLabel.snp.bottom).offset(Metric.guideLabelTopMargin)
    }
  }
  
  private func makeItemHistoryCollectionViewConstraints() {
    ItemHistoryCollectionView.snp.makeConstraints {
      $0.leading.equalTo(sectionHeaderTitleLabel)
      $0.top.equalTo(sectionHeaderTitleLabel.snp.bottom).offset(Metric.itemHistoryCollectionViewTopMargin)
      $0.bottom.equalToSuperview().offset(-Metric.itemHistoryCollectionViewBottomMargin)
    }
  }
}
