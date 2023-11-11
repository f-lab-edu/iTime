//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/25.
//

import Foundation

extension Encodable {
  public func toJson() -> [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    return json as? [String: Any]
  }
}
