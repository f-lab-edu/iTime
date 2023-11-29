//
//  File.swift
//  
//
//  Created by 이상헌 on 11/22/23.
//

import BaseRepository
import NetworkRepository

// MARK: - BookmarkDocumentSnapshotMock

public final class DocumentSnapshotMock: iTimeDocumentSnapshot {
  public var documentID: String = DummyData.DummyID.documentID
  private let configuration: DummyDataConfiguration
  
  public init(configuration: DummyDataConfiguration) {
    self.configuration = configuration
  }
  
  public func data() -> Dictionary<String, Any>? {
    return configuration.data
  }
}

// MARK: - BookmarkQuerySnapshotMock

public final class QuerySnapshotMock: iTimeQuerySnapshot {
  private let configuration: DummyDataConfiguration
  public lazy var iTimeDocuments: [iTimeDocumentSnapshot] = [DocumentSnapshotMock(configuration: configuration)]
  
  public init(configuration: DummyDataConfiguration) {
    self.configuration = configuration
  }
}
