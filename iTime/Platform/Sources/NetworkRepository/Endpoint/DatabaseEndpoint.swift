//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/27.
//

import Foundation

// MARK: - DocumentReferenceConvertible

public protocol DocumentReferenceConvertible {
  var referencePath: String { get }
}

// MARK: - DatabaseEndpoint

public enum DatabaseEndpoint: String {
  case userSession = "users"
  case activitySession = "activity_session"
  case bookmarkSession = "bookmark_session"
  case categorySession = "category_session"
  case logSession = "log_session"
}
