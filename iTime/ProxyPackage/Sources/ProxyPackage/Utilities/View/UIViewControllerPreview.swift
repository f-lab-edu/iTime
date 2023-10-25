//
//  UIViewControllerPreview.swift
//  RIBsReactorKit
//
//  Created by sangheon on 2023/04/17.
//

import UIKit

#if canImport(SwiftUI) && DEBUG
import SwiftUI

public struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewController
    
    public init(_ builder: @escaping () -> ViewController) {
        self.viewController = builder()
    }
    
    // MARK: - UIViewControllerRepresentable
    
    public func makeUIViewController(context: Context) -> ViewController {
        self.viewController
    }
    
    public func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}
#endif
