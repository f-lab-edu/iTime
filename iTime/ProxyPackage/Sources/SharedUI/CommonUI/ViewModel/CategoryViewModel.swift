//
//  File.swift
//  
//
//  Created by 이상헌 on 1/5/24.
//

import UIKit


public struct CategoryViewModel: Equatable {
  public let color: UIColor
  public let title: String
  
  public init(color: UIColor, title: String) {
    self.color = color
    self.title = title
  }
}

//extension CategoryViewModel {
//  func toCategory() -> Entities.Category {
//    .init(
//      title: title,
//      color: color.toHex ?? ""
//    )
//  }
//}
