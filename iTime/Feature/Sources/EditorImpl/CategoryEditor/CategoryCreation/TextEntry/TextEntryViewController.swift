//
//  TextEntryViewController.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - TextEntryPresentableListener

protocol TextEntryPresentableListener: AnyObject {
}

// MARK: - TextEntryViewController

final class TextEntryViewController:
  BaseViewController,
  TextEntryPresentable,
  TextEntryViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: TextEntryPresentableListener?
  
  // MARK: - UI Components
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Bind Action

extension TextEntryViewController {
  
}

// MARK: - Bind State

extension TextEntryViewController {
  
}

// MARK: - Layout

extension TextEntryViewController {
  private func setupUI() {
    
    layout()
  }
  
  private func layout() {
    
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  TextEntryViewController()
}
#endif
