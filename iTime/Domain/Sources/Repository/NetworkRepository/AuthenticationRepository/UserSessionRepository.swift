//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/31.
//

import RxSwift

import Entities

public protocol UserSessionRepository {
  func sessionObservable(with userID: String) -> Observable<UserModel?>
  func createSessionIfNeeded(_ session: UserModel, for userID: String) -> Observable<UserModel>
  func updateSession(_ session: UserModel, for userID: String) -> Observable<UserModel>
}
