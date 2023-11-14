//
//  File.swift
//  
//
//  Created by 이상헌 on 11/14/23.
//

import UIKit

import SharedUI

final class BookmarkEmptyView: BaseView {
  
  // MARK: - Constants
  
  private enum Metric {
    static let emojiImageSizeView: CGFloat = 72
    static let bookamarkRouteLabelTopMargin: CGFloat = 18
    static let guideLabelTopMargin: CGFloat = 14
  }
  
  // MARK: - UI Components
  
  // Gif 또는 Image가 추후 추가 예정
  private let emojiImageView = UIImageView().builder
    .backgroundColor(.red)
    .build()
  
  private let guideLabel = UILabel().builder
    .text("즐겨찾기를 등록해\n빠른 활동 시작을 해보세요")
    .numberOfLines(2)
    .textAlignment(.center)
    .build()
  
  private let bookmarkRouteLabel = UILabel().builder
    .text("즐겨찾기 이동")
    .textAlignment(.center)
    .textColor(.pointGreen)
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
  
  private func setupUI() {
    addSubview(emojiImageView)
    addSubview(guideLabel)
    addSubview(bookmarkRouteLabel)
  }
  
  private func layout() {
    makeEmojiImageViewConstraints()
    makeGuideLabelConstraints()
    makeBookmarkRouteLabel()
  }
  
  private func makeEmojiImageViewConstraints() {
    emojiImageView.snp.makeConstraints {
      $0.size.equalTo(Metric.emojiImageSizeView)
      $0.top.equalToSuperview()
      $0.centerX.equalToSuperview()
    }
  }
  
  private func makeGuideLabelConstraints() {
    guideLabel.snp.makeConstraints {
      $0.top.equalTo(emojiImageView.snp.bottom).offset(Metric.guideLabelTopMargin)
      $0.leading.trailing.equalToSuperview()
      $0.centerX.equalToSuperview()
    }
  }
  
  private func makeBookmarkRouteLabel() {
    bookmarkRouteLabel.snp.makeConstraints {
      $0.top.equalTo(guideLabel.snp.bottom).offset(Metric.bookamarkRouteLabelTopMargin)
      $0.centerX.bottom.equalToSuperview()
    }
  }
}
