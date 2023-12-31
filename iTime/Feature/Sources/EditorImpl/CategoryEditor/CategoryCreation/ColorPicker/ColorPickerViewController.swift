//
//  ColorPickerViewController.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - ColorPickerPresentableListener

protocol ColorPickerPresentableListener: AnyObject {
}

// MARK: - ColorPickerViewController

final class ColorPickerViewController:
  BaseViewController,
  ColorPickerPresentable,
  ColorPickerViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: ColorPickerPresentableListener?
  
  // MARK: - UI Components
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
}

// MARK: - Bind Action

extension ColorPickerViewController {
  
}

// MARK: - Bind State

extension ColorPickerViewController {
  
}

// MARK: - Layout

extension ColorPickerViewController {
  private func setupUI() {
    
    layout()
  }
  
  private func layout() {
    
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  ColorPickerViewController()
}
#endif
