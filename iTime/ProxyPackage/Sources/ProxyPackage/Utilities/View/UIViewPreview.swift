//
//  UIViewPreview.swift
//  RIBsReactorKit
//
//  Created by sangheon on 2023/04/17.
//

import UIKit

#if canImport(SwiftUI) && DEBUG
  import SwiftUI

  struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View

    init(_ builder: @escaping () -> View) {
      self.view = builder()
    }

    // MARK: - UIViewRepresentable

    func makeUIView(context: Context) -> UIView {
      self.view
    }

    func updateUIView(_ view: UIView, context: Context) {
      view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
      view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
  }
#endif
