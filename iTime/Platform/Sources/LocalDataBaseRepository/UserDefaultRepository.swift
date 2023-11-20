//
//  File.swift
//
//
//  Created by 이상헌 on 11/20/23.
//

import Foundation

// MARK: - UserDefaultRepository

public protocol UserDefaultRepository: AnyObject {
  var userID: String { get set }
  var isAppBackground: Bool { get set }
}

// MARK: - Key

public enum UserDefaultKey: String {
  case userID
  case isAppBackground
}
