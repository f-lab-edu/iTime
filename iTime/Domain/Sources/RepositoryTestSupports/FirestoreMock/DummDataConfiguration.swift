//
//  File.swift
//  
//
//  Created by 이상헌 on 11/28/23.
//

import NetworkRepository

// MARK: - DummDataConfiguration

/// unit test시 기존 interface를 깨뜨리지 않고 CRUD를 가짜데이터에 반영하여 테스트를 돕도록 만들어진 객체
public final class DummyDataConfiguration {
  
  public var data: [String: Any] = [:]
  
  public func update(with data: [String: Any]) {
    self.data = data
  }
  
  public init() {}
}
