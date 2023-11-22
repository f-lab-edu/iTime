//
//  File.swift
//
//
//  Created by 이상헌 on 2023/10/31.
//

import RxSwift

import NetworkRepository
import AppFoundation

final class UserSessionRepositoryImpl: UserSessionRepository {
  
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
  
  // MARK: - Properties
  
  private let firestoreRepository: FirestoreRepository
  
  // MARK: - Initialization
  
  public init(firestoreRepository: FirestoreRepository) {
    self.firestoreRepository = firestoreRepository
  }
  
  // MARK: - Methods
  
  func sessionObservable(with userID: String) -> Observable<UserSession?> {
    firestoreRepository.documentObservable(for: DatabaseReference.singleUser(userID: userID), includeMetadata: true)
      .compactMap { try? $0.decode() }
  }
  
  func createSessionIfNeeded(_ session: UserSession, for userID: String) -> Observable<UserSession> {
    sessionObservable(with: userID)
      .withUnretained(self)
      .flatMap { this, oldSession -> Observable<Void> in
        if oldSession == nil {
          return this.firestoreRepository.update(
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
        this.firestoreRepository.update(
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
