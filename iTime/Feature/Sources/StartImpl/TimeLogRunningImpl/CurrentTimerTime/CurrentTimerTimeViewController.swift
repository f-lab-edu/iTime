//
//  CurrentTimerTimeViewController.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - CurrentTimerTimePresentableListener

protocol CurrentTimerTimePresentableListener: AnyObject {
}

// MARK: - CurrentTimerTimeViewController

final class CurrentTimerTimeViewController:
  BaseViewController,
  CurrentTimerTimePresentable,
  CurrentTimerTimeViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: CurrentTimerTimePresentableListener?
  
  // MARK: - UI Components
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Bind Action

extension CurrentTimerTimeViewController {
  
}

// MARK: - Bind State

extension CurrentTimerTimeViewController {
  
}

// MARK: - Layout

extension CurrentTimerTimeViewController {
  private func setupUI() {
    
    layout()
  }
  
  private func layout() {
    
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  CurrentTimerTimeViewController()
}
#endif
