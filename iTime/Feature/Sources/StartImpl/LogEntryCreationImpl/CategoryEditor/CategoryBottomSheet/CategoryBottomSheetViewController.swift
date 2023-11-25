//
//  CategoryBottomSheetViewController.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - CategoryBottomSheetPresentableListener

protocol CategoryBottomSheetPresentableListener: AnyObject {
}

// MARK: - CategoryBottomSheetViewController

final class CategoryBottomSheetViewController:
  BaseViewController,
  CategoryBottomSheetPresentable,
  CategoryBottomSheetViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: CategoryBottomSheetPresentableListener?
  
  // MARK: - UI Components
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Bind Action

extension CategoryBottomSheetViewController {
  
}

// MARK: - Bind State

extension CategoryBottomSheetViewController {
  
}

// MARK: - Layout

extension CategoryBottomSheetViewController {
  private func setupUI() {
    
    layout()
  }
  
  private func layout() {
    
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  CategoryBottomSheetViewController()
}
#endif
