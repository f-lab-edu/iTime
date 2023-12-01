//
//  File.swift
//  
//
//  Created by 이상헌 on 11/26/23.
//

import Foundation

public struct Coordinate: Codable {
  public let latitude: Double
  public let longitude: Double
  
  public init(latitude: Double, longitude: Double) {
    self.latitude = latitude
    self.longitude = longitude
  }
}
