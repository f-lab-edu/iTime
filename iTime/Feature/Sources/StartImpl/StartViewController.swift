//
//  StartViewController.swift
//
//
//  Created by 이상헌 on 11/11/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - StartPresentableListener

protocol StartPresentableListener: AnyObject {
}

// MARK: - StartViewController

final class StartViewController:
  BaseViewController,
  StartPresentable,
  StartViewControllable
{
  
  // MARK: - Properties
  
  weak var listener: StartPresentableListener?
  
  // MARK: - UI Components
  
  private let containterView = UIView()
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setTabBarItem()
  }
  
  // MARK: - Private methods
  
  private func setTabBarItem() {
    tabBarItem = UITabBarItem(
      title: "Start",
      image: .timer,
      selectedImage: .timerFill
    )
  }
  
}

// MARK: - Layout

extension StartViewController {
  private func setupUI() {
    view.addSubview(containterView)
    layout()
  }
  
  private func layout() {
    containterView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }
  
  func addChildView(_ view: ViewControllable) {
    let vc = view.uiviewController
    addChild(vc)
    containterView.addSubview(vc.view)
    vc.view.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
    vc.didMove(toParent: self)
  }
  
  func removeChild(_ view: ViewControllable) {
    let vc = view.uiviewController
    vc.willMove(toParent: nil)
    vc.view.removeFromSuperview()
    vc.removeFromParent()
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  StartViewController()
}
#endif
