//
//  TimeLogRunningViewController.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - TimeLogRunningPresentableListener

protocol TimeLogRunningPresentableListener: AnyObject {
}

// MARK: - TimeLogRunningViewController

final class TimeLogRunningViewController:
  BaseViewController,
  TimeLogRunningPresentable,
  TimeLogRunningViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: TimeLogRunningPresentableListener?
  
  // MARK: - UI Components
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Bind Action

extension TimeLogRunningViewController {
  
}

// MARK: - Bind State

extension TimeLogRunningViewController {
  
}

// MARK: - Layout

extension TimeLogRunningViewController {
  private func setupUI() {
    
    layout()
  }
  
  private func layout() {
    
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  TimeLogRunningViewController()
}
#endif
