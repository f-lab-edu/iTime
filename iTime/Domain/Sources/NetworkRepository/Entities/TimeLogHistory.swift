//
//  File.swift
//  
//
//  Created by 이상헌 on 11/26/23.
//

import Foundation

// MARK: - TimeLogHistory

public struct TimeLogHistory: Codable {
  let id: String
  let activity: Activity
  let startTime: String
  let endTime: String
  let coordinate: Coordinate2D
}
