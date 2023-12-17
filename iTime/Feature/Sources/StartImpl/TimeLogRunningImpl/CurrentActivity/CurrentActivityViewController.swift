//
//  CurrentActivityViewController.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - CurrentActivityPresentableListener

protocol CurrentActivityPresentableListener: AnyObject {
}

// MARK: - CurrentActivityViewController

final class CurrentActivityViewController:
  BaseViewController,
  CurrentActivityPresentable,
  CurrentActivityViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: CurrentActivityPresentableListener?
  
  // MARK: - UI Components
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Bind Action

extension CurrentActivityViewController {
  
}

// MARK: - Bind State

extension CurrentActivityViewController {
  
}

// MARK: - Layout

extension CurrentActivityViewController {
  private func setupUI() {
    
    layout()
  }
  
  private func layout() {
    
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  CurrentActivityViewController()
}
#endif
