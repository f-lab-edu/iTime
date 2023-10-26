//
//  SceneDelegate.swift
//  iTime
//
//  Created by 이상헌 on 2023/10/23.
//

import UIKit

import RIBs

// MARK: - SceneDelegate

class SceneDelegate:
    UIResponder,
    UIWindowSceneDelegate
{
    
    // MARK: - Properties
    
    var window: UIWindow?
    
    private var launchRouter: LaunchRouting?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window
        
        configureAppLaunch()
    }
}

extension SceneDelegate {
    private func configureAppLaunch() {
        guard let window = window else { return }
        let appComponent = AppComponent()
        self.launchRouter = appComponent.appRootBuilder.build()
        self.launchRouter?.launch(from: window)
    }
}

