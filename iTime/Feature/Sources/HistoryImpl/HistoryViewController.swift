//
//  HistoryViewController.swift
//  
//
//  Created by 이상헌 on 12/7/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - HistoryPresentableListener

protocol HistoryPresentableListener: AnyObject {
}

// MARK: - HistoryViewController

final class HistoryViewController:
  BaseViewController,
  HistoryPresentable,
  HistoryViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: HistoryPresentableListener?
  
  // MARK: - UI Components
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Bind Action

extension HistoryViewController {
  
}

// MARK: - Bind State

extension HistoryViewController {
  
}

// MARK: - Layout

extension HistoryViewController {
  private func setupUI() {
    
    layout()
  }
  
  private func layout() {
    
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  HistoryViewController()
}
#endif
