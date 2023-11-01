//
//  LoggedOutViewController.swift
//  
//
//  Created by 이상헌 on 2023/10/31.
//
import UIKit
import AuthenticationServices

import RIBs
import RxCocoa
import RxSwift
import SnapKit

import ProxyPackage

protocol LoggedOutPresentableListener: AnyObject {
    func requestAppleLogin(_ presenter: ASAuthorizationContextProviding)
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
    
    deinit {
        print(type(of: self))
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
            .drive(with: self) { owner, _ in
                owner.listener?.requestAppleLogin(owner)
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
        
        self.layout()
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

// MARK: - ASAuthorizationContextProviding

extension LoggedOutViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        self.view.window ?? .init()
    }
}
