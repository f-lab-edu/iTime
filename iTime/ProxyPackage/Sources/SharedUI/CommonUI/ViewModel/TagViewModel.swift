//
//  File.swift
//  
//
//  Created by 이상헌 on 12/28/23.
//

import UIKit

public struct TagViewModel {
  let title: String
  let borderWidth: CGFloat
  let backgroundColor: UIColor
  let font: UIFont
  
  public init(
    title: String,
    borderWidth: CGFloat = 0,
    backgroundColor: UIColor = .black90,
    font: UIFont = .custom(.regular, 14)
  ) {
    self.title = title
    self.borderWidth = borderWidth
    self.backgroundColor = backgroundColor
    self.font = font
  }
}
