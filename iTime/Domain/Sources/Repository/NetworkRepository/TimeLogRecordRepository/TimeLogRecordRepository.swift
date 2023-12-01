//
//  File.swift
//  
//
//  Created by 이상헌 on 11/26/23.
//

import RxSwift
import Entities

public protocol TimeLogRecordRepository {
  func append(_ record: TimeLogRecord) -> Single<[TimeLogRecord]>
  func remove(with logID: String) -> Single<[TimeLogRecord]>
  func timeLogHistories() -> Single<[TimeLogRecord]>
}
