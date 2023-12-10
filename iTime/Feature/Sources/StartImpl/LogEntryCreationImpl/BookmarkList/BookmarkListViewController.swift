//
//  BookmarkListViewController.swift
//  
//
//  Created by 이상헌 on 12/10/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - BookmarkListPresentableListener

protocol BookmarkListPresentableListener: AnyObject {
}

// MARK: - BookmarkListViewController

final class BookmarkListViewController:
  BaseViewController,
  BookmarkListPresentable,
  BookmarkListViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: BookmarkListPresentableListener?
  
  // MARK: - UI Components
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Bind Action

extension BookmarkListViewController {
  
}

// MARK: - Bind State

extension BookmarkListViewController {
  
}

// MARK: - Layout

extension BookmarkListViewController {
  private func setupUI() {
    
    layout()
  }
  
  private func layout() {
    
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  BookmarkListViewController()
}
#endif
