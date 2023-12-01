//
//  File.swift
//  
//
//  Created by 이상헌 on 12/1/23.
//

public struct Coordinate2D {
  public let latitude: Double
  public let longitude: Double
  
  public init(latitude: Double, longitude: Double) {
    self.latitude = latitude
    self.longitude = longitude
  }
}

extension Coordinate2D {
  public static let zero: Coordinate2D = .init(latitude: 0.0, longitude: 0.0)
}
