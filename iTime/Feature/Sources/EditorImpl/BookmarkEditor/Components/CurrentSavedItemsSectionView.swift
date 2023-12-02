//
//  File.swift
//  
//
//  Created by 이상헌 on 11/14/23.
//

import UIKit

import SharedUI

final class CurrentSavedItemsSectionView: 
  BaseView,
  BookmarkCollectionViewCellDelegate,
  BookmarkTagsCollectionViewAdapterDataSource
{
  
  // MARK: - Constants
  
  private enum Metric {
    static let sectionHeaderTitleLabelLeadingMargin: CGFloat = 24
    static let sectionHeaderTitleLabelTopMargin: CGFloat = 16
    static let currentCountIndexLabelTrailingMargin: CGFloat = 24
    static let emptyGuideLabelTopMargin: CGFloat = 4
    static let emptyGuideLabelBottomMargin: CGFloat = 24
    static let savedItemCollectionViewTopMargin: CGFloat = 4
    static let savedItemCollectionViewBottomMargin: CGFloat = 20
    static let savedItemCollectionViewLeadingTrailingMargin: CGFloat = 24
  }
  
  // MARK: - UI Components
  
  private let sectionHeaderTitleLabel = UILabel().builder
    .text("현재 저장된 활동")
    .font(.custom(.bold, 16))
    .textColor(.black40)
    .build()
  
  private let currentCountIndexLabel = UILabel().builder
    .text("3/6")
    .font(.custom(.regular, 16))
    .textColor(.black40)
    .build()
  
  private let emptyGuideLabel = UILabel().builder
    .text("자주 하시는 활동으로 저장해보세요!")
    .font(.custom(.regular, 12))
    .textColor(.black60)
    .build()
  
  private let savedItemCollectionView = DynamicHeightCollectionView(
    frame: .zero,
    collectionViewLayout: .init()
  )
  
  private lazy var adapter = BookmarkTagsCollectionViewAdapter(
    collectionView: savedItemCollectionView,
    adapterDataSource: self,
    delegate: self,
    alignedCollectionViewFlowLayout: LeadingAlignedCollectionViewFlowLayout()
  )
  
  // MARK: - properties
  
  private weak var delegateDataSource: SavedItemSectionDelegateDataSource?
  
  // MARK: - Initialization & Deinitialization
  
  init(delegateDataSource: SavedItemSectionDelegateDataSource?) {
    self.delegateDataSource = delegateDataSource
    super.init(frame: .zero)
  }
  
  // MARK: Delegate & DataSource
  
  func didTapTagCell() {
    guard let delegateDataSource = delegateDataSource else { return }
    delegateDataSource.didTapSaveItemSectionCell()
  }
  
  func numberOfItems() -> Int {
    guard let delegateDataSource = delegateDataSource else { return  -1 }
    return delegateDataSource.numberOfSavedItems()
  }
  
  func bookmark(at index: Int) -> String {
    guard let delegateDataSource = delegateDataSource else { return String() }
    return delegateDataSource.configurationSavedItem(at: index)
  }
  
  // MARK: - Layout
  
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
    addSubview(currentCountIndexLabel)
    addSubview(emptyGuideLabel)
    addSubview(savedItemCollectionView)
    _ = adapter
  }
  
  private func layout() {
    makeSectionHeaderTitleLabelConstraints()
    makeCurrentCountIndexLabelConstraints()
  //  makeEmptyGuideLabelConstraints()
    makeSavedItemCollectionViewConstraints()
  }
  
  private func makeSectionHeaderTitleLabelConstraints() {
    sectionHeaderTitleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(Metric.sectionHeaderTitleLabelLeadingMargin)
      $0.top.equalToSuperview().offset(Metric.sectionHeaderTitleLabelTopMargin)
    }
  }
  
  private func makeCurrentCountIndexLabelConstraints() {
    currentCountIndexLabel.snp.makeConstraints {
      $0.centerY.equalTo(sectionHeaderTitleLabel)
      $0.trailing.equalToSuperview().offset(-Metric.currentCountIndexLabelTrailingMargin)
    }
  }
  
  private func makeEmptyGuideLabelConstraints() {
    emptyGuideLabel.snp.makeConstraints {
      $0.leading.equalTo(sectionHeaderTitleLabel)
      $0.top.equalTo(sectionHeaderTitleLabel.snp.bottom).offset(Metric.emptyGuideLabelTopMargin)
      $0.bottom.equalToSuperview().offset(-Metric.emptyGuideLabelBottomMargin).priority(.low)
    }
  }
  
  private func makeSavedItemCollectionViewConstraints() {
    savedItemCollectionView.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(Metric.savedItemCollectionViewLeadingTrailingMargin)
      $0.top.equalTo(sectionHeaderTitleLabel.snp.bottom).offset(Metric.savedItemCollectionViewTopMargin)
      $0.bottom.equalToSuperview().offset(-Metric.savedItemCollectionViewBottomMargin)
    }
  }
  
}
