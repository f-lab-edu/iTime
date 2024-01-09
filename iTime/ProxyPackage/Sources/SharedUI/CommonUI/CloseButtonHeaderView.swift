//
//  File.swift
//
//
//  Created by 이상헌 on 11/13/23.
//

import UIKit

import SnapKit

public final class CloseButtonHeaderView: BaseView {
  
  // MARK: - Constants
  
  private enum Metric {
    static let buttonSize: CGFloat = 44
    static let separatedViewHeight: CGFloat = 1
  }
  
  public let closeButton = UIButton().builder
    .with {
      $0.setImage(.exit, for: .normal)
    }
    .build()
  
  private let separatedView = UIView().builder
    .backgroundColor(.black90)
    .build()
  
  public override func initialize() {
    super.initialize()
    backgroundColor = .clear
    addSubview(closeButton)
    addSubview(separatedView)
  }
  
  public override func setupConstraints() {
    super.setupConstraints()
    makeCloseButtonConstraints()
    makeSeparatedViewConstraints()
  }
  
  private func makeCloseButtonConstraints() {
    let safeArea = safeAreaLayoutGuide.snp
    
    closeButton.snp.makeConstraints {
      $0.size.equalTo(Metric.buttonSize)
      $0.centerY.equalToSuperview()
      $0.top.bottom.greaterThanOrEqualToSuperview().inset(4)
      $0.leading.equalTo(safeArea.leading).offset(8)
    }
  }
  
  private func makeSeparatedViewConstraints() {
    separatedView.snp.makeConstraints {
      $0.leading.trailing.bottom.equalToSuperview()
      $0.height.equalTo(Metric.separatedViewHeight)
    }
  }
}
