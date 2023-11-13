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
    static let buttonHeight: CGFloat = 30
  }
  
  let closeButton = UIButton().builder
    .contentEdgeInsets(UIEdgeInsets(
      top: 10,
      left: 15,
      bottom: 10,
      right: 15
      )
    )
    .backgroundColor(.black)
    .build()
  
  public override func initialize() {
    super.initialize()
    backgroundColor = .red
    addSubview(self.closeButton)
  }
  
  public override func setupConstraints() {
    super.setupConstraints()
    self.makeCloseButtonConstraints()
  }
  
  private func makeCloseButtonConstraints() {
    let safeArea = safeAreaLayoutGuide.snp
    
    closeButton.snp.makeConstraints {
      $0.height.equalTo(Metric.buttonHeight)
      $0.centerY.equalToSuperview()
      $0.top.bottom.equalToSuperview().inset(4)
      $0.trailing.greaterThanOrEqualTo(safeArea.leading).offset(15)
      $0.leading.equalTo(safeArea.leading).offset(8)
    }
  }
}
