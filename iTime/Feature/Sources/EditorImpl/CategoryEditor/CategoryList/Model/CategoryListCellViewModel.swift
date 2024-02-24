//
//  File.swift
//  
//
//  Created by 이상헌 on 1/5/24.
//

import UIKit

import Entities

public struct CategoryListCellViewModel: Equatable {
  let color: UIColor
  let title: String
}

extension CategoryListCellViewModel {
  func toCategory() -> Entities.Category {
    .init(
      title: title,
      color: color.toHex ?? ""
    )
  }
}
