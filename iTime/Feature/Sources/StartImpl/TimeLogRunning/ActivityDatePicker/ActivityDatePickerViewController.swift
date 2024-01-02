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
import AppFoundation

// MARK: - ActivityDatePickerPresentableListener

public protocol ActivityDatePickerPresentableListener: AnyObject {
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
  private let timeFormatter: TimeFormatter
  
  // MARK: - Initialziation
  
  init(timeFormatter: TimeFormatter) {
    self.timeFormatter = timeFormatter
  }
  
  // MARK: - UI Components
  
  private lazy var datePickerSectionView = DatePickerSectionView(timeFormatter: timeFormatter)
  
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
    view.addSubview(datePickerSectionView)
    
    layout()
  }
  
  private func layout() {
    datePickerSectionView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  ActivityDatePickerViewController(timeFormatter: TimeFormatter())
}
#endif
