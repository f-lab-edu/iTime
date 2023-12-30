//
//  File.swift
//  
//
//  Created by 이상헌 on 12/19/23.
//

import Entities
import AppFoundation

public struct ActivityLog: PropertyBuilderCompatible {
  public var title: String?
  public var category: CategotyLog?
  
  public init(title: String? = nil, category: CategotyLog? = nil) {
    self.title = title
    self.category = category
  }
}

extension Activity {
  public static func toActivity(_ activity: ActivityLog) throws -> Self {
    Activity(
      title: try activity.title.unwrap(),
      category: try .toCategory(activity.category.unwrap())
    )
  }
}
