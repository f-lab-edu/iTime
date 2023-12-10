//
//  LoggingRetentionViewController.swift
//  
//
//  Created by 이상헌 on 12/10/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - LoggingRetentionPresentableListener

protocol LoggingRetentionPresentableListener: AnyObject {
}

// MARK: - LoggingRetentionViewController

final class LoggingRetentionViewController:
  BaseViewController,
  LoggingRetentionPresentable,
  LoggingRetentionViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: LoggingRetentionPresentableListener?
  
  // MARK: - UI Components
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Bind Action

extension LoggingRetentionViewController {
  
}

// MARK: - Bind State

extension LoggingRetentionViewController {
  
}

// MARK: - Layout

extension LoggingRetentionViewController {
  private func setupUI() {
    
    layout()
  }
  
  private func layout() {
    
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  LoggingRetentionViewController()
}
#endif
