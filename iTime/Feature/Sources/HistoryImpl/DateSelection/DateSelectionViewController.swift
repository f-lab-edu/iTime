//
//  DateSelectionViewController.swift
//  
//
//  Created by 이상헌 on 12/7/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - DateSelectionPresentableListener

protocol DateSelectionPresentableListener: AnyObject {
}

// MARK: - DateSelectionViewController

final class DateSelectionViewController:
  BaseViewController,
  DateSelectionPresentable,
  DateSelectionViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: DateSelectionPresentableListener?
  
  // MARK: - UI Components
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Bind Action

extension DateSelectionViewController {
  
}

// MARK: - Bind State

extension DateSelectionViewController {
  
}

// MARK: - Layout

extension DateSelectionViewController {
  private func setupUI() {
    
    layout()
  }
  
  private func layout() {
    
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  DateSelectionViewController()
}
#endif
