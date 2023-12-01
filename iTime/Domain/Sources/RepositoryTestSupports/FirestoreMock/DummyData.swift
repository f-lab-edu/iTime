//
//  File.swift
//  
//
//  Created by 이상헌 on 11/26/23.
//

import Foundation

import Entities
import Repository

public enum DummyData {
  public enum DummyID {
    public static let userID = "TestUserID"
    public static let documentID = "TestDocumentID"
    public static let timeLogHistoryID = "TestTimeLogHistoryID"
  }
  public enum DummyBookmark {
    public static let dummyBookmarkOne: Bookmark = .init(title: "테스트1", category: .init(title: "테스트", color: "테스트"))
    public static let dummyBookmarkTwo: Bookmark = .init(title: "테스트2", category: .init(title: "테스트", color: "테스트"))
    
    public static let dummyBookmarksOne: [Bookmark] = [dummyBookmarkOne]
    public static let dummyBookmarksTwo: [Bookmark] = [dummyBookmarkOne, dummyBookmarkOne]
    public static let dummyBookmarksThree: [Bookmark] = [dummyBookmarkOne, dummyBookmarkOne, dummyBookmarkOne]
    public static let dummyBookmarksFour: [Bookmark] = [dummyBookmarkOne, dummyBookmarkOne, dummyBookmarkOne, dummyBookmarkOne]
  }
  
  public enum DummyTimeLogHistory {
    public static let dummyTimeLogRecord: TimeLogRecord = .init(id: DummyID.timeLogHistoryID, activity: .empty, startTime: "10:10:22", endTime: "20:20:33", coordinate: .zero)
    public static let dummyTimeLogRecords: [TimeLogRecord] = [dummyTimeLogRecord, dummyTimeLogRecord, dummyTimeLogRecord, dummyTimeLogRecord]
  }
}
