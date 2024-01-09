//
//  File.swift
//  
//
//  Created by 이상헌 on 11/12/23.
//

import UIKit

extension UIView {
  public func addCornerRadius(
    _ radius: CGFloat,
    widthBorder: CGFloat? = nil,
    borderColor: UIColor? = nil
  ) {
      layer.cornerRadius = radius
      if let _widthBorder = widthBorder,
         let _borderColor = borderColor {
          layer.borderColor = _borderColor.cgColor
          layer.borderWidth = _widthBorder
      }
      layer.masksToBounds = true
  }
  
  public func addCornerRadius(
    corners: UIRectCorner,
    cornerRadius: CGSize = .zero
  ) {
      let path = UIBezierPath(
        roundedRect: bounds,
        byRoundingCorners: corners,
        cornerRadii: cornerRadius
      )
      let maskLayer = CAShapeLayer()
      maskLayer.path = path.cgPath
      layer.mask = maskLayer
      layer.masksToBounds = true
  }
}
