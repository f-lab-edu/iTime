//
//  AppRootViewController.swift
//  iTime
//
//  Created by 이상헌 on 2023/10/26.
//

import UIKit
import RIBs
import SnapKit

import ProxyPackage

// MARK: - AppRootPresentableListener

protocol AppRootPresentableListener: AnyObject {}

// MARK: - AppRootViewController

final class AppRootViewController:
    BaseViewController,
    AppRootPresentable,
    AppRootViewControllable
{
    
    // MARK: UI Components
    
    private lazy var splashImageView = UIImageView()
        .builder
        .contentMode(.scaleAspectFill)
        .backgroundColor(.gray)
        .build()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    weak var listener: AppRootPresentableListener?
    
}

// MARK: - Layout

extension AppRootViewController {
    private func setupUI() {
        view.addSubview(splashImageView)
        
        self.layout()
    }
    
    private func layout() {
        splashImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.133)
            $0.width.equalToSuperview().multipliedBy(0.32)
        }
    }
}
