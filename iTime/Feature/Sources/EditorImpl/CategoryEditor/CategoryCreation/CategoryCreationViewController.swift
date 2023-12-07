//
//  CategoryCreationViewController.swift
//  
//
//  Created by 이상헌 on 12/7/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - CategoryCreationPresentableListener

protocol CategoryCreationPresentableListener: AnyObject {
}

// MARK: - CategoryCreationViewController

final class CategoryCreationViewController:
  BaseViewController,
  CategoryCreationPresentable,
  CategoryCreationViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: CategoryCreationPresentableListener?
  
  // MARK: - UI Components
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Bind Action

extension CategoryCreationViewController {
  
}

// MARK: - Bind State

extension CategoryCreationViewController {
  
}

// MARK: - Layout

extension CategoryCreationViewController {
  private func setupUI() {
    
    layout()
  }
  
  private func layout() {
    
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  CategoryCreationViewController()
}
#endif
