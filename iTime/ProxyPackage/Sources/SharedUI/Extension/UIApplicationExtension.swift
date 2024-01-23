//
//  File.swift
//  
//
//  Created by 이상헌 on 1/23/24.
//

import UIKit

extension UIApplication {
    func topViewController() -> UIViewController? {
      UIApplication.shared
          .connectedScenes.lazy
          .compactMap { $0.activationState == .foregroundActive ? ($0 as? UIWindowScene) : nil }
          .first(where: { $0.keyWindow != nil })?
          .keyWindow?
          .rootViewController?
          .topViewController()
    }
}
