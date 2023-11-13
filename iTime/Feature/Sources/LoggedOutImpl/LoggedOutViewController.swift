//
//  LoggedOutViewController.swift
//  
//
//  Created by 이상헌 on 2023/10/31.
//
import UIKit

import RIBs
import RxCocoa
import RxSwift
import SnapKit

import SharedUI
import AppFoundation

protocol LoggedOutPresentableListener: AnyObject {
  func requestAppleLogin()
}

final class LoggedOutViewController:
  BaseViewController,
  LoggedOutPresentable,
  LoggedOutViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    
  }
  
  // MARK: - Properties
  
  weak var listener: LoggedOutPresentableListener?
  
  // MARK: - UI Components
  
  private lazy var appleLoginButton = UIButton().builder
    .backgroundColor(.blue)
    .build()
  
  // MARK: - View Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindActions()
    setupUI()
  }
}

// MARK: - Bind Action

extension LoggedOutViewController {
  private func bindActions() {
    appleLoginButtonTapAction()
  }
  
  private func appleLoginButtonTapAction() {
    appleLoginButton.rx
      .tapWithPreventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { this, _ in
        this.listener?.requestAppleLogin()
      }
      .disposed(by: disposeBag)
  }
}

// MARK: - LoggedOutPresentable

extension LoggedOutViewController {
  func presentErrorMessage(_ message: String) {
    alert(message)
  }
}

// MARK: - Layout

extension LoggedOutViewController {
  private func setupUI() {
    view.backgroundColor = .white
    view.addSubview(appleLoginButton)
    
    layout()
  }
  
  private func layout() {
    makeAppleLoginButtonLayout()
  }
  
  // FIXME: 디자인 나온 후 레이아웃 반영
  private func makeAppleLoginButtonLayout() {
    appleLoginButton.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.height.equalTo(80)
      $0.width.equalTo(200)
    }
  }
}


