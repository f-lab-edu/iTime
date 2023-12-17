//
//  CurrentTimerTimeViewController.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - CurrentTimerTimePresentableListener

protocol CurrentTimerTimePresentableListener: AnyObject {
  func loadCurrentTime()
}

// MARK: - CurrentTimerTimeViewController

final class CurrentTimerTimeViewController:
  BaseViewController,
  CurrentTimerTimePresentable,
  CurrentTimerTimeViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: CurrentTimerTimePresentableListener?
  
  // MARK: - UI Components
  
  private let mainCurrentTimeLabel = UILabel().builder
    .text("0:00:03")
    .font(.custom(.bold, 40))
    .textColor(.white)
    .build()
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindLoadCurrentTime()
  }
  
  func currentRunningTime(_ time: String) {
    mainCurrentTimeLabel.text = time
  }
  
  private func bindLoadCurrentTime() {
    rx.viewWillAppear
      .throttle(.seconds(1), latest: false ,scheduler: MainScheduler.instance)
      .subscribe(with: self) { owner, _ in
        owner.listener?.loadCurrentTime()
      }
      .disposed(by: disposeBag)
  }
}

// MARK: - Layout

extension CurrentTimerTimeViewController {
  private func setupUI() {
    view.addSubview(mainCurrentTimeLabel)
    
    layout()
  }
  
  private func layout() {
    mainCurrentTimeLabel.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  CurrentTimerTimeViewController()
}
#endif
