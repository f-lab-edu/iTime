//
//  TimerOperationViewController.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - TimerOperationPresentableListener

protocol TimerOperationPresentableListener: AnyObject {
}

// MARK: - TimerOperationViewController

final class TimerOperationViewController:
  BaseViewController,
  TimerOperationPresentable,
  TimerOperationViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: TimerOperationPresentableListener?
  
  // MARK: - UI Components
  
  private let timeOperatorButtonsView = TimeOperatorButtonsView()
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Bind Action

extension TimerOperationViewController {
  
}

// MARK: - Bind State

extension TimerOperationViewController {
  
}

// MARK: - Layout

extension TimerOperationViewController {
  private func setupUI() {
    view.addSubview(timeOperatorButtonsView)
    
    layout()
  }
  
  private func layout() {
    timeOperatorButtonsView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  TimerOperationViewController()
}
#endif
