//
//  AppDelegate.swift
//  iTime
//
//  Created by 이상헌 on 2023/10/23.
//

import UIKit

import FirebaseCore
import FirebaseFirestore

import ProxyPackage


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
