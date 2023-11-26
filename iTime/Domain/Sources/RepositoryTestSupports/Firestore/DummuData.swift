//
//  File.swift
//  
//
//  Created by 이상헌 on 11/26/23.
//

import Foundation

import NetworkRepository

public enum DummyData {
  public enum DummyID {
    public static let userID = "TestUserID"
    public static let documentID = "TestDocumentID"
    public static let timeLogHistoryID = "TestTimeLogHistoryID"
  }
  public enum DummyBookmark {
    public static let dummyBookmark: Activity = .init(title: "테스트", category: .init(title: "테스트", color: "테스트"))
    public static let dummyBookmarks: [Activity] = [dummyBookmark, dummyBookmark, dummyBookmark, dummyBookmark]
    public static let dummyBookmarkList: BookmarkList = BookmarkList(dummyBookmarks)
  }
  
  public enum DummyTimeLogHistory {
    public static let dummyTimeLogHistory: TimeLogHistory = .init(id: DummyID.timeLogHistoryID, activity: DummyBookmark.dummyBookmark, startTime: "10:10:22", endTime: "20:20:33", coordinate: .empty)
    public static let dummyTimeLogHisotries: [TimeLogHistory] = [dummyTimeLogHistory, dummyTimeLogHistory, dummyTimeLogHistory, dummyTimeLogHistory]
    public static let dummyTimeLogHistoryList: TimeLogHistoryList = TimeLogHistoryList(dummyTimeLogHisotries)
  }
}
