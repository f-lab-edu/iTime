//
//  ActivityDatePickerViewController.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - ActivityDatePickerPresentableListener

protocol ActivityDatePickerPresentableListener: AnyObject {
}

// MARK: - ActivityDatePickerViewController

final class ActivityDatePickerViewController:
  BaseViewController,
  ActivityDatePickerPresentable,
  ActivityDatePickerViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: ActivityDatePickerPresentableListener?
  
  // MARK: - UI Components
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Bind Action

extension ActivityDatePickerViewController {
  
}

// MARK: - Bind State

extension ActivityDatePickerViewController {
  
}

// MARK: - Layout

extension ActivityDatePickerViewController {
  private func setupUI() {
    
    layout()
  }
  
  private func layout() {
    
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  ActivityDatePickerViewController()
}
#endif
