//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/31.
//

import Foundation

// TODO: 세션 데이터 채워넣기 필요
public struct UserSession: Codable {
  public var data: String
  
  public init(_ data: String) {
    self.data = data
  }
}
