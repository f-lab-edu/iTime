//
//  File.swift
//  
//
//  Created by 이상헌 on 11/19/23.
//

import Foundation

public struct Classification: Codable {
  public let title: String
  public let color: String
  
  public init(title: String, color: String) {
    self.title = title
    self.color = color
  }
}
