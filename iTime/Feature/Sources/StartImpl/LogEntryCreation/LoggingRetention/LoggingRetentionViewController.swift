//
//  LoggingRetentionViewController.swift
//  
//
//  Created by 이상헌 on 12/10/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - LoggingRetentionPresentableListener

protocol LoggingRetentionPresentableListener: AnyObject {
  func didTaploggingRetentionBox()
  func didTaploggingRetentionBoxCloseButton()
}

// MARK: - LoggingRetentionViewController

final class LoggingRetentionViewController:
  BaseViewController,
  LoggingRetentionPresentable,
  LoggingRetentionViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: LoggingRetentionPresentableListener?
  
  // MARK: - UI Components
  
  private let loggingRetentionBoxView = LoggingRetentionBoxView()
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindActions()
  }
  
}

// MARK: - Bind Action

extension LoggingRetentionViewController {
  private func bindActions() {
    bindLoggingRetentionBoxViewTapAction()
    bindLoggingRetentionBoxCloseButtonTapAction()
  }
  
  private func bindLoggingRetentionBoxViewTapAction() {
    Observable.merge(
      loggingRetentionBoxView.guideLabel.rx.tapGestureWithPreventDuplication(),
      loggingRetentionBoxView.rightAccessoryImageView.rx.tapGestureWithPreventDuplication()
    )
    .asDriver(onErrorDriveWith: .empty())
         .drive(with: self) { owner, _ in owner.listener?.didTaploggingRetentionBox() }
    .disposed(by: disposeBag)
  }
  
  private func bindLoggingRetentionBoxCloseButtonTapAction() {
    loggingRetentionBoxView.closeButton.rx.tap
      .preventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in owner.listener?.didTaploggingRetentionBoxCloseButton() }
      .disposed(by: disposeBag)
  }
}

// MARK: - Bind State

extension LoggingRetentionViewController {
  
}

// MARK: - Layout

extension LoggingRetentionViewController {
  private func setupUI() {
    view.backgroundColor = .clear
    view.addSubview(loggingRetentionBoxView)
    
    layout()
  }
  
  private func layout() {
    makeLoggingRetentionBoxViewConstraints()
  }
  
  private func makeLoggingRetentionBoxViewConstraints() {
    loggingRetentionBoxView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  LoggingRetentionViewController()
}
#endif
