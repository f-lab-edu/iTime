//
//  CurrentLoggingViewController.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - CurrentLoggingPresentableListener

protocol CurrentLoggingPresentableListener: AnyObject {
}

// MARK: - CurrentLoggingViewController

final class CurrentLoggingViewController:
  BaseViewController,
  CurrentLoggingPresentable,
  CurrentLoggingViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: CurrentLoggingPresentableListener?
  
  // MARK: - UI Components
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Bind Action

extension CurrentLoggingViewController {
  
}

// MARK: - Bind State

extension CurrentLoggingViewController {
  
}

// MARK: - Layout

extension CurrentLoggingViewController {
  private func setupUI() {
    
    layout()
  }
  
  private func layout() {
    
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  CurrentLoggingViewController()
}
#endif
