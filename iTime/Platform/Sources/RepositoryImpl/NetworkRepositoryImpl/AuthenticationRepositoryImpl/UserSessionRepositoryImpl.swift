//
//  File.swift
//
//
//  Created by 이상헌 on 2023/10/31.
//
import OSLog

import RxSwift

import Models
import Entities
import BaseRepository
import Repository
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
  
  func sessionObservable(with userID: String) -> Observable<UserModel?> {
    firestoreRepository.documentObservable(for: DatabaseReference.singleUser(userID: userID), includeMetadata: true)
      .compactMap { try? $0.decode() }
      .map(UserModel.init(data:))
  }
  
  func createSessionIfNeeded(_ session: UserModel, for userID: String) -> Observable<UserModel> {
    sessionObservable(with: userID)
      .withUnretained(self)
      .flatMap { this, oldSession -> Observable<Void> in
        if oldSession == nil {
          return this.firestoreRepository.update(
            reference: DatabaseReference.singleUser(userID: userID),
            with: this.unwrappedUserSession(session: session),
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
  
  func updateSession(_ session: UserModel, for userID: String) -> Observable<UserModel> {
    sessionObservable(with: userID)
      .withUnretained(self)
      .flatMap { this, _ in
        this.firestoreRepository.update(
          reference: DatabaseReference.singleUser(userID: userID),
          with: this.unwrappedUserSession(session: session),
          merge: true
        )
      }
      .withUnretained(self)
      .flatMap { this, _ in
        this.sessionObservable(with: userID).compactMap { $0 }
      }
  }
  
  private func unwrappedUserSession(session: UserModel) -> [String: Any] {
    do {
      return try UserSession(session.data).toJson().unwrap()
    } catch {
      os_log(.error, log: .infra, "UserSession unwrapping fail")
    }
    return [:]
  }
  
}
