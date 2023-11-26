//
//  File.swift
//  
//
//  Created by 이상헌 on 11/22/23.
//

import NetworkRepository

// MARK: - BookmarkDocumentSnapshotMock

public final class BookmarkDocumentSnapshotMock: iTimeDocumentSnapshot {
  public var documentID: String = DummyData.DummyID.documentID
  
  public func data() -> Dictionary<String, Any>? {
    return DummyData.DummyBookmark.dummyBookmarkList.toJson()
  }
  
  public init() {}
}

// MARK: - BookmarkQuerySnapshotMock

public final class BookmarkQuerySnapshotMock: iTimeQuerySnapshot {
  public var iTimeDocuments: [iTimeDocumentSnapshot] = [BookmarkDocumentSnapshotMock()]
  public init() {}
}
