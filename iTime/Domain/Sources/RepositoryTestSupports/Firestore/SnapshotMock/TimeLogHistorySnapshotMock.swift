//
//  File.swift
//  
//
//  Created by 이상헌 on 11/26/23.
//

import NetworkRepository

// MARK: - TimeLogHistoryDocumentSnapshotMock

public final class TimeLogHistoryDocumentSnapshotMock: iTimeDocumentSnapshot {
  public var documentID: String = DummyData.DummyID.documentID
  
  public func data() -> Dictionary<String, Any>? {
    return DummyData.DummyTimeLogHistory.dummyTimeLogHistoryList.toJson()
  }
  public init() {}
}

// MARK: - TimeLogHistorykQuerySnapshotMock

public final class TimeLogHistorykQuerySnapshotMock: iTimeQuerySnapshot {
  public var iTimeDocuments: [iTimeDocumentSnapshot] = [TimeLogHistoryDocumentSnapshotMock()]
  public init() {}
}
