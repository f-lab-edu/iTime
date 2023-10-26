//
//  LoggedOutViewController.swift
//  
//
//  Created by 이상헌 on 2023/10/26.
//

import UIKit
import AuthenticationServices

import RIBs
import RxCocoa
import RxSwift

import ProxyPackage

// MARK: - LoggedOutViewController

final class LoggedOutViewController:
    BaseViewController,
    LoggedOutPresentable,
    LoggedOutViewControllable
{
    
    // MARK: - Constants
    
    private enum UI {
        
    }
    
    // MARK: - Properties
    
    weak var listener: LoggedOutPresentableListener?
    
    private let actionRelay = PublishRelay<LoggedOutPresentableListener.Action>()
    
    // MARK: - UI Components
    
    // MARK: - Initialization & Deinitialization
    
    override init() {
        super.init()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupUI()
        bindUI()
        bind(listener: self.listener)
    }
}


// MARK: Private methods

extension LoggedOutViewController {}

// MARK: - Bind UI

extension LoggedOutViewController {
    private func bindUI() {
        
    }
}

// MARK: - Bind listener

extension LoggedOutViewController {
    private func bind(listener: LoggedOutPresentableListener?) {
        guard let listener = listener else { return }
    }
    
    private func bindActionRelay() {
        self.actionRelay.asObservable()
          .bind(with: self) { onwer, action in
            onwer.listener?.sendAction(action)
          }
          .disposed(by: disposeBag)
    }
}

// MARK: - Binding Action

extension LoggedOutViewController {
    private func bindActions() {
        
    }
}

// MARK: - Binding State

extension LoggedOutViewController {
    private func bindState(from listener: LoggedOutPresentableListener) {
        
    }
}

// MARK: - Layout

extension LoggedOutViewController {
    private func setupUI() {
        
        self.layout()
    }
    
    private func layout() {
        
    }
}

extension LoggedOutViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window ?? .init()
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct LoggedOutPreView: PreviewProvider {
    static var previews: some SwiftUI.View {
        ForEach(Device.deviceNames, id: \.self) { deviceName in
            UIViewControllerPreview {
                let viewController = LoggedOutViewController()
                
                return UINavigationController(rootViewController: viewController)
            }
            .previewDevice(PreviewDevice(rawValue: deviceName))
            .previewDisplayName(deviceName)
        }
    }
}

#endif
