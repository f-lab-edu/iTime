//
//  RunningGIFViewController.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - RunningGIFPresentableListener

protocol RunningGIFPresentableListener: AnyObject {
}

// MARK: - RunningGIFViewController

final class RunningGIFViewController:
  BaseViewController,
  RunningGIFPresentable,
  RunningGIFViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: RunningGIFPresentableListener?
  
  // MARK: - UI Components
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Bind Action

extension RunningGIFViewController {
  
}

// MARK: - Bind State

extension RunningGIFViewController {
  
}

// MARK: - Layout

extension RunningGIFViewController {
  private func setupUI() {
    
    layout()
  }
  
  private func layout() {
    
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  RunningGIFViewController()
}
#endif
