//
//  File.swift
//  
//
//  Created by 이상헌 on 11/13/23.
//

import UIKit

// MARK: - HasCloseButtonHeaderView

public protocol HasCloseButtonHeaderView {
  var needHeaderView: Bool { get }
  var headerView: CloseButtonHeaderView { get }
}

extension HasCloseButtonHeaderView where Self: UIViewController {
  public var needHeaderView: Bool {
    true
  }

  public func addHeaderViewIfNeeded(to view: UIView) {
    guard self.needHeaderView else { return }
    view.addSubview(headerView)
  }

  public func makeHeaderViewConstraintsIfNeeded() {
    guard self.needHeaderView else { return }
    headerView.snp.makeConstraints {
      $0.height.equalTo(52)
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.leading.trailing.equalToSuperview()
    }
  }
}
