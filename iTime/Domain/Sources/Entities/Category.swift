//
//  File.swift
//  
//
//  Created by 이상헌 on 12/1/23.
//

public struct Category: Equatable {
  public let title: String
  public let color: String
  
  public init(title: String, color: String) {
    self.title = title
    self.color = color
  }
}

extension Category {
  public static let empty: Category = .init(
    title: String(),
    color: String()
  )
}
