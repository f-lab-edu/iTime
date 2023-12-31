//
//  Ribs+Util.swift
//  omos
//
//  Created by sangheon on 2023/04/09.
//

import Foundation
import RIBs
import UIKit

public final class NavigationControllerable: ViewControllable {
    
    public var uiviewController: UIViewController { self.navigationController }
    public let navigationController: UINavigationController
    
    public init(root: ViewControllable) {
        let navigation = UINavigationController(rootViewController: root.uiviewController)
        navigation.navigationBar.isTranslucent = false
        navigation.navigationBar.backgroundColor = .white
        navigation.navigationBar.scrollEdgeAppearance = navigation.navigationBar.standardAppearance
        navigation.title = "@@@@@@"
        
        self.navigationController = navigation
    }
}

public extension ViewControllable {
    
    func present(_ viewControllable: ViewControllable, animated: Bool, completion: (() -> Void)?) {
        self.uiviewController.present(viewControllable.uiviewController, animated: animated, completion: completion)
    }
    
    func presentOverVeritcally(_ viewControllable: ViewControllable, animated: Bool, completion: (() -> Void)?) {
        viewControllable.uiviewController.modalPresentationStyle = .overCurrentContext
        viewControllable.uiviewController.modalTransitionStyle = .coverVertical
        self.uiviewController.present(viewControllable.uiviewController, animated: animated, completion: completion)
    }
    
    func presentFullScreen(_ viewControllable: ViewControllable, animated: Bool, completion: (() -> Void)?) {
        viewControllable.uiviewController.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async { [weak self] in
            self?.uiviewController.present(viewControllable.uiviewController, animated: animated, completion: completion)
        }
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
      DispatchQueue.main.async { [weak self] in
        self?.uiviewController.dismiss(animated: animated, completion: completion)
      }
    }
    
    func pushViewController(_ viewControllable: ViewControllable, animated: Bool) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.pushViewController(viewControllable.uiviewController, animated: animated)
        } else {
            self.uiviewController.navigationController?.pushViewController(viewControllable.uiviewController, animated: animated)
        }
    }
    
    func popViewController(animated: Bool, completion: (() -> Void)?) {
        if let nav = self.uiviewController as? UINavigationController {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            nav.popViewController(animated: animated)
            CATransaction.commit()
        } else {
            CATransaction.begin()
            CATransaction.setCompletionBlock(completion)
            self.uiviewController.navigationController?.popViewController(animated: animated)
            CATransaction.commit()
        }
    }
    
    func popToRoot(animated: Bool) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.popToRootViewController(animated: animated)
        } else {
            self.uiviewController.navigationController?.popToRootViewController(animated: animated)
        }
    }
    
    func setViewControllers(_ viewControllerables: [ViewControllable]) {
        if let nav = self.uiviewController as? UINavigationController {
            nav.setViewControllers(viewControllerables.map(\.uiviewController), animated: true)
        } else {
            self.uiviewController.navigationController?.setViewControllers(viewControllerables.map(\.uiviewController), animated: true)
        }
    }
    
    var topViewControllable: ViewControllable {
        var top: ViewControllable = self
        
        while let presented = top.uiviewController.presentedViewController as? ViewControllable {
            top = presented
        }
        
        return top
    }
}
