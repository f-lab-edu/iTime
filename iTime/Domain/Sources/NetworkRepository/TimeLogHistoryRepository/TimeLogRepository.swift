//
//  File.swift
//  
//
//  Created by 이상헌 on 11/26/23.
//

import RxSwift

public protocol TimeLogHistoryRepository {
  func append(_ history: TimeLogHistory) -> Single<Void>
  func remove(with logID: String) -> Single<Void>
  func timeLogHistories() -> Single<[TimeLogHistory]>
}
