//
//  LoggedInViewController.swift
//  
//
//  Created by 이상헌 on 2023/11/02.
//

import RIBs
import UIKit
import RxSwift

import SharedUI
import AppFoundation

protocol LoggedInPresentableListener: AnyObject {}

final class LoggedInViewController:
  UITabBarController,
  LoggedInPresentable,
  LoggedInViewControllable
{
  
  // MARK: - Properties

  weak var listener: LoggedInPresentableListener?
  
  // MARK: - Initialziation & Deinitializaition
  
  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    assertionFailure("init(coder:) has not been implemented")
  }
  
  // MARK: - View Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setTabBarSettings()
  }
  
  private func setTabBarSettings() {
    tabBar.backgroundColor = .black90
    tabBar.tintColor = .pointGreen
    tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.5)
  }
  
  func setViewControllers(_ viewControllers: [ViewControllable], animated: Bool) {
    self.setViewControllers(
      viewControllers.map(\.uiviewController),
      animated: animated
    )
  }
}
