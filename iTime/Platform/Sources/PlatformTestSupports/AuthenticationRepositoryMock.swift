//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/29.
//

import Platform

// MARK: - AuthenticationRepositoryMock

public final class AuthenticationRepositoryMock: AuthenticationRepository {
  
  public var signInCallCount = 0
  public var componentCallCount: Any?
  public func signIn(_ components: Any?...) {
    signInCallCount += 1
    componentCallCount = components
  }
  
  public var signOutCallCount = 0
  public func signOut() {
    signOutCallCount += 1
  }
  
  public var deleteCurrentUserCallCount = 0
  public func deleteCurrentUser() {
    deleteCurrentUserCallCount += 1
  }
  
  public var isLoggedInCallCount = 0
  public func isLoggedIn() -> Bool {
    isLoggedInCallCount += 1
    return true
  }
  
  public init() {}
}
