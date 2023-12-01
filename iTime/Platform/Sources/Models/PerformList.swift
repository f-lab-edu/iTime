//
//  File.swift
//  
//
//  Created by 이상헌 on 11/26/23.
//

import Foundation

// MARK: - PerformList

public struct PerformList: Codable {
  public let performs: [Perform]
  
  public init(_ performs: [Perform]) {
    self.performs = performs
  }
}
