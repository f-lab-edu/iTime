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
    public static let dummyBookmarkOne: Activity = .init(title: "테스트1", category: .init(title: "테스트", color: "테스트"))
    public static let dummyBookmarkTwo: Activity = .init(title: "테스트2", category: .init(title: "테스트", color: "테스트"))
    
    public static let dummyBookmarksOne: [Activity] = [dummyBookmarkOne]
    public static let dummyBookmarksTwo: [Activity] = [dummyBookmarkOne, dummyBookmarkOne]
    public static let dummyBookmarksThree: [Activity] = [dummyBookmarkOne, dummyBookmarkOne, dummyBookmarkOne]
    public static let dummyBookmarksFour: [Activity] = [dummyBookmarkOne, dummyBookmarkOne, dummyBookmarkOne, dummyBookmarkOne]
    public static let dummyBookmarkList: BookmarkList = BookmarkList(dummyBookmarksFour)
  }
  
  public enum DummyTimeLogHistory {
    public static let dummyTimeLogHistory: TimeLogHistory = .init(id: DummyID.timeLogHistoryID, activity: DummyBookmark.dummyBookmarkOne, startTime: "10:10:22", endTime: "20:20:33", coordinate: .empty)
    public static let dummyTimeLogHisotries: [TimeLogHistory] = [dummyTimeLogHistory, dummyTimeLogHistory, dummyTimeLogHistory, dummyTimeLogHistory]
    public static let dummyTimeLogHistoryList: TimeLogHistoryList = TimeLogHistoryList(dummyTimeLogHisotries)
  }
}
