//
//  BookmarkRepositoryImpl.swift
//  
//
//  Created by 이상헌 on 11/19/23.
//

import RxSwift

import NetworkRepository
import NetworkRepositoryImpl
import BookmarkRepository

public final class BookmarkRepositoryImpl: FirestoreRepository, BookmarkRepository {
  
  // MARK: - DocumentReferenceConvertible
  
  enum DatabaseReference: DocumentReferenceConvertible {
    case bookmarkSession
    
    var referencePath: String {
      switch self {
        case let .singleUser(userID):
          return "\(DatabaseEndpoint.userSession.rawValue)/\(userID)"
      }
    }
  }
  
  // MARK: - Methods
  
  public func update() {
    
  }
}
