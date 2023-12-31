//
//  TimerOperationViewController.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - TimerOperationPresentableListener

protocol TimerOperationPresentableListener: AnyObject {
  func didTapStartButton()
  func didTapPauseButton()
  func didTapStopButton()
}

// MARK: - TimerOperationViewController

final class TimerOperationViewController:
  BaseViewController,
  TimerOperationPresentable,
  TimerOperationViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: TimerOperationPresentableListener?
  
  // MARK: - UI Components
  
  private let timeOperatorButtonsView = TimeOperatorButtonsView()
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    
    bindActions()
  }
  
}

// MARK: - Bind Action

extension TimerOperationViewController {
  private func bindActions() {
    bindDidTapStartButton()
    bindDidTapPauseButton()
    bindDidTapStopButton()
  }
  
  private func bindDidTapStartButton() {
    timeOperatorButtonsView.startButton.rx
      .tapWithPreventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in
        owner.listener?.didTapStartButton()
      }
      .disposed(by: disposeBag)
  }
  
  private func bindDidTapPauseButton() {
    timeOperatorButtonsView.pauseButton.rx
      .tapWithPreventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in
        owner.listener?.didTapPauseButton()
      }
      .disposed(by: disposeBag)
  }
  
  private func bindDidTapStopButton() {
    timeOperatorButtonsView.stopButton.rx
      .tapWithPreventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in
        owner.listener?.didTapStopButton()
      }
      .disposed(by: disposeBag)
  }
  
}

// MARK: - Bind State

extension TimerOperationViewController {
  func isTimeRunning(_ isRunning: Bool) {
    timeOperatorButtonsView.pauseButton.isHidden = !isRunning
  }
}

// MARK: - Layout

extension TimerOperationViewController {
  private func setupUI() {
    view.addSubview(timeOperatorButtonsView)
    
    layout()
  }
  
  private func layout() {
    timeOperatorButtonsView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  TimerOperationViewController()
}
#endif
