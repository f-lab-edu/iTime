//
//  File.swift
//
//
//  Created by 이상헌 on 1/23/24.
//

import UIKit
import XCTest

public extension UIViewController {
  
  func firstChild<T: UIViewController>(of type: T.Type) -> T? {
    if let result = self as? T {
      return result
    }
    
    for child in self.children {
      if let result = child.firstChild(of: T.self) {
        return result
      }
    }
    
    return nil
  }

  func topViewController() -> UIViewController? {
    
    if let presented = self.presentedViewController {
      return presented.topViewController()
    }
    
    if let navigation = self as? UINavigationController {
      return navigation.visibleViewController?.topViewController()
    }
    
    if let tab = self as? UITabBarController {
      return tab.selectedViewController?.topViewController() ?? tab
    }
    
    return self
  }
}


