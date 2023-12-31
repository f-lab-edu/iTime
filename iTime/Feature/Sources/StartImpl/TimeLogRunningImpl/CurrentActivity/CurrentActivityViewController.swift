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
  func loadData()
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
  
  private let tagView = TagView()
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    
    bindLoadData()
  }
  
}

// MARK: - Bind Action

extension CurrentActivityViewController {
  private func bindLoadData() {
    rx.viewWillAppear
      .throttle(.seconds(1), latest: false, scheduler: MainScheduler.asyncInstance)
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in
        owner.listener?.loadData()
      }
      .disposed(by: disposeBag)
  }
}

// MARK: - Bind State

extension CurrentActivityViewController {
  func bindTageViewTitle(_ title: String) {
    tagView.configure(by: title)
  }
}

// MARK: - Layout

extension CurrentActivityViewController {
  private func setupUI() {
    view.addSubview(tagView)
    
    layout()
  }
  
  private func layout() {
    tagView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  CurrentActivityViewController()
}
#endif
