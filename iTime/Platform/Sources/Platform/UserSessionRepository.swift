//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/31.
//

import RxSwift

public protocol UserSessionRepository {
  func sessionObservable(with userID: String) -> Observable<UserSession?>
  func createSessionIfNeeded(_ session: UserSession, for userID: String) -> Observable<UserSession>
  func updateSession(_ session: UserSession, for userID: String) -> Observable<UserSession>
}
