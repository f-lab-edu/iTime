//
//  File.swift
//  
//
//  Created by 이상헌 on 12/16/23.
//

import Foundation

public struct DisplayErrorMessage {
  public let title: String?
  public let message: String?
  public let confirmActionTitle: String
  
  public init(title: String? = nil, message: String? = nil, confirmActionTitle: String = String()) {
    self.title = title
    self.message = message
    self.confirmActionTitle = confirmActionTitle
  }
}
