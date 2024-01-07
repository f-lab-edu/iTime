//
//  File.swift
//
//
//  Created by 이상헌 on 1/5/24.
//

import UIKit

import Entities
import AppFoundation

import SharedUI

public struct CategoryListViewModel {
  var sections: [CategoryListSection] = []
}

// MARK: - TimeLogRecord

extension CategoryListViewModel {
  init(_ timeLogRecords: [TimeLogRecord]) {
    self.sections = [.category(Self.makeCategoryListSections(timeLogRecords))]
  }
  
  private static func makeCategoryListSections(_ timeLogRecord: [TimeLogRecord]) -> [CategoryListSection.Item] {
    timeLogRecord.map {
      return .list(
        .init(
          color: UIColor(hex: $0.activity.category.color) ?? .black,
          title: $0.activity.category.title
        )
      )
    }
  }
}
