//
//  File.swift
//  
//
//  Created by 이상헌 on 11/22/23.
//

import RxSwift

import BaseRepository
import NetworkRepository

public final class FirestoreRepositoryMock: FirestoreRepository {
  
  private let documentSnapshotMock: iTimeDocumentSnapshot
  private let querySnapshotMock: iTimeQuerySnapshot
  private let configuration: DummyDataConfiguration
  
  public init(
    documentSnapshotMock: iTimeDocumentSnapshot,
    querySnapShotMock: iTimeQuerySnapshot,
    configuration: DummyDataConfiguration
  ) {
    self.documentSnapshotMock = documentSnapshotMock
    self.querySnapshotMock = querySnapShotMock
    self.configuration = configuration
  }
  
  public var createCallcount: Int = 0
  public func create(
    reference: DocumentReferenceConvertible,
    with data: [String : Any]
  ) -> Observable<String> {
    createCallcount += 1
    return .just(DummyData.DummyID.documentID)
  }
  
  public var updateCallCount: Int = 0
  public func update(
    reference: DocumentReferenceConvertible,
    with data: [String : Any],
    merge: Bool
  ) -> Observable<String> {
    updateCallCount += 1
    configuration.update(with: data)
    return .just(DummyData.DummyID.documentID)
  }
  
  public var collectionObservableCallCount: Int = 0
  public func collectionObservable(
    for reference: DocumentReferenceConvertible,
    includeMetadata: Bool
  ) -> Observable<iTimeQuerySnapshot> {
    collectionObservableCallCount += 1
    return .just(querySnapshotMock)
  }
  
  public var documentObservableCallCount: Int = 0
  public func documentObservable(
    for reference: DocumentReferenceConvertible,
    includeMetadata: Bool
  ) -> Observable<iTimeDocumentSnapshot> {
    documentObservableCallCount += 1
    return .just(documentSnapshotMock)
  }
}
