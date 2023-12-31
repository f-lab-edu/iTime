//
//  CategoryListViewController.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - CategoryListPresentableListener

protocol CategoryListPresentableListener: AnyObject {
}

// MARK: - CategoryListViewController

final class CategoryListViewController:
  BaseViewController,
  CategoryListPresentable,
  CategoryListViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: CategoryListPresentableListener?
  
  // MARK: - UI Components
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Bind Action

extension CategoryListViewController {
  
}

// MARK: - Bind State

extension CategoryListViewController {
  
}

// MARK: - Layout

extension CategoryListViewController {
  private func setupUI() {
    
    layout()
  }
  
  private func layout() {
    
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  CategoryListViewController()
}
#endif
