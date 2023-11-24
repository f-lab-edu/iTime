//
//  File.swift
//  
//
//  Created by 이상헌 on 11/22/23.
//

import NetworkRepository

// MARK: - iTimeDocumentSnapshotMock

final class iTimeDocumentSnapshotMock: iTimeDocumentSnapshot {
  var documentID: String = "TestDocumentID"
  
  func data() -> Dictionary<String, Any>? {
    return DummyData.DummyBookmark.dummyBookmarkList.toJson()
  }
}

// MARK: - iTimeQuerySnapshotMock

final class iTimeQuerySnapshotMock: iTimeQuerySnapshot {
  var iTimeDocuments: [iTimeDocumentSnapshot] = [iTimeDocumentSnapshotMock()]
}
