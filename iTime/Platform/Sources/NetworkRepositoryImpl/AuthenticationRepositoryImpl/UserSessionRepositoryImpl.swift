//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/31.
//

import RxSwift

import NetworkRepository
import NetworkRepositoryImpl
import AppFoundation

final class UserSessionRepositoryImpl: FirestoreRepository, UserSessionRepository {
  
  // MARK: - DatabaseReference
  
  enum DatabaseReference: DocumentReferenceConvertible {
    case singleUser(userID: String)
    
    var referencePath: String {
      switch self {
        case let .singleUser(userID):
          return "\(DatabaseEndpoint.userSession.rawValue)/\(userID)"
      }
    }
  }
  
  // MARK: - Methods
  
  func sessionObservable(with userID: String) -> Observable<UserSession?> {
    documentObservable(for: DatabaseReference.singleUser(userID: userID), includeMetadata: true)
      .compactMap { try? $0.decode() }
  }
  
  func createSessionIfNeeded(_ session: UserSession, for userID: String) -> Observable<UserSession> {
    sessionObservable(with: userID)
      .withUnretained(self)
      .flatMap { this, oldSession -> Observable<Void> in
        if oldSession == nil {
          return this.update(
            reference: DatabaseReference.singleUser(userID: userID),
            with: session.toJson() ?? [:],
            merge: false
          )
          .map { _ in Void() }
        } else {
          return Observable.error(MyError.duplicatedSession)
        }
      }
      .withUnretained(self)
      .flatMap { this, _ in
        this.sessionObservable(with: userID).compactMap { $0 }
      }
  }
  
  func updateSession(_ session: UserSession, for userID: String) -> Observable<UserSession> {
    sessionObservable(with: userID)
      .withUnretained(self)
      .flatMap { this, _ in
        this.update(
          reference: DatabaseReference.singleUser(userID: userID),
          with: session.toJson() ?? [:],
          merge: true
        )
      }
      .withUnretained(self)
      .flatMap { this, _ in
        this.sessionObservable(with: userID).compactMap { $0 }
      }
  }
}
