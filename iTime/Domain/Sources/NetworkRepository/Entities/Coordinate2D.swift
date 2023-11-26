//
//  File.swift
//  
//
//  Created by 이상헌 on 11/26/23.
//

import Foundation

public struct Coordinate2D: Codable {
  let latitude: Double
  let longitude: Double
}

extension Coordinate2D {
  static let empty: Coordinate2D = .init(latitude: 0.0, longitude: 0.0)
}
