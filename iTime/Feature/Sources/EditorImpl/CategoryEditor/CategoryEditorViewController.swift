//
//  CategoryEditorViewController.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - CategoryEditorPresentableListener

protocol CategoryEditorPresentableListener: AnyObject {
}

// MARK: - CategoryEditorViewController

final class CategoryEditorViewController:
  BaseViewController,
  CategoryEditorPresentable,
  CategoryEditorViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: CategoryEditorPresentableListener?
  
  // MARK: - UI Components
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Bind Action

extension CategoryEditorViewController {
  
}

// MARK: - Bind State

extension CategoryEditorViewController {
  
}

// MARK: - Layout

extension CategoryEditorViewController {
  private func setupUI() {
    
    layout()
  }
  
  private func layout() {
    
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  CategoryEditorViewController()
}
#endif
