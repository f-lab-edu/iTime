//
//  File.swift
//  
//
//  Created by 이상헌 on 11/26/23.
//

import Foundation

// MARK: - Activity

public struct Perform:
  Codable,
  Equatable
{
  public let title: String
  public let classification: Classification
  
  public init(title: String, classification: Classification) {
    self.title = title
    self.classification = classification
  }
  
  public static func == (lhs: Perform, rhs: Perform) -> Bool {
    lhs.title == rhs.title
  }
}

