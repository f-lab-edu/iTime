//
//  File.swift
//  
//
//  Created by 이상헌 on 11/22/23.
//

import RxSwift

import NetworkRepository

public final class FirestoreRepositoryMock: FirestoreRepository {
  
  public var createCallcount: Int = 0
  public func create(reference: DocumentReferenceConvertible, with data: [String : Any]) -> Observable<String> {
    createCallcount += 1
    return .just(DummyData.DummyID.documentID)
  }
  
  public var updateCallCount: Int = 0
  public func update(reference: DocumentReferenceConvertible, with data: [String : Any], merge: Bool) -> Observable<String> {
    updateCallCount += 1
    return .just(DummyData.DummyID.documentID)
  }
  
  public var collectionObservableCallCount: Int = 0
  public func collectionObservable(for reference: DocumentReferenceConvertible, includeMetadata: Bool) -> Observable<iTimeQuerySnapshot> {
    collectionObservableCallCount += 1
    return .just(iTimeQuerySnapshotMock())
  }
  
  public var documentObservableCallCount: Int = 0
  public func documentObservable(for reference: DocumentReferenceConvertible, includeMetadata: Bool) -> Observable<iTimeDocumentSnapshot> {
    documentObservableCallCount += 1
    return .just(iTimeDocumentSnapshotMock())
  }
  
  public init() {}
}

public enum DummyData {
  public enum DummyID {
    public static let userID = "TestUserID"
    public static let documentID = "TestDocumentID"
  }
  public enum DummyBookmark {
    public static let dummyBookmark: Bookmark = .init(title: "테스트", category: .init(title: "테스트", color: "테스트"))
    public static let dummyBookmarks: [Bookmark] = [dummyBookmark, dummyBookmark, dummyBookmark, dummyBookmark]
  }

}
