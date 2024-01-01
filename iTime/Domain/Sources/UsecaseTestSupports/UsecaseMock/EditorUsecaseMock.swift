//
//  File.swift
//  
//
//  Created by 이상헌 on 1/1/24.
//

import RxSwift
import Entities
import RepositoryTestSupports
import Usecase

public class EditorUsecaseMock: EditorUsecase {
  public var dummyBookmarks: [Bookmark] = []
  public var dummyTimeLogRecord: [TimeLogRecord] = []
  
  public func uploadBookmarks() -> RxSwift.Single<Void> {
    dummyBookmarks.append(contentsOf: DummyData.DummyBookmark.dummyBookmarksFour)
    return .just(Void())
  }
  
  public func uploadTimeLogRecord() -> RxSwift.Single<Void> {
    dummyTimeLogRecord.append(contentsOf: DummyData.DummyTimeLogRecord.dummyTimeLogRecords)
    return .just(Void())
  }
  
  public init() {}
}
