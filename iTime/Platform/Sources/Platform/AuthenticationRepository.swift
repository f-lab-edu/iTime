//
//  File.swift
//
//
//  Created by 이상헌 on 2023/10/26.
//

// MARK: - AuthenticationRepository

public protocol AuthenticationRepository {
  func signIn(_ components: Any?...)
  func signOut()
  func deleteCurrentUser()
  func isLoggedIn() -> Bool
}
