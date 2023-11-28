//
//  File.swift
//
//
//  Created by 이상헌 on 2023/10/27.
//

import FirebaseFirestore
import RxSwift

import BaseRepository
import NetworkRepository

// MARK: - DocumentSnapshot & QuerySnapshot

extension DocumentSnapshot: iTimeDocumentSnapshot {}

extension QuerySnapshot: iTimeQuerySnapshot {
  public var iTimeDocuments: [iTimeDocumentSnapshot] {
    self.documents
  }
}

// MARK: - FirestoreRepository Implemetation

public final class FirestoreRepositoryImpl {
  public func create(
    reference: DocumentReferenceConvertible,
    with data: [String : Any]
  ) -> Observable<String> {
    Observable.create { observer in
      let document = Firestore.firestore().collection(reference.referencePath).document()
      document.setData(data, merge: true) { error in
        if let error = error {
          observer.onError(error)
        } else {
          observer.onNext(document.documentID)
        }
      }
      return Disposables.create()
    }
  }
  
  public func update(
    reference: DocumentReferenceConvertible,
    with data: [String: Any],
    merge: Bool
  ) -> Observable<String> {
    Observable.create { observer in
      let document = Firestore.firestore().document(reference.referencePath)
      document.setData(data, merge: merge) { error in
        if let error = error{
          observer.onError(error)
        } else {
          observer.onNext(document.documentID)
        }
      }
      return Disposables.create()
    }
  }
  
  public func collectionObservable(
    for reference: DocumentReferenceConvertible,
    includeMetadata: Bool
  ) -> Observable<iTimeQuerySnapshot> {
    let changesSubject = PublishSubject<iTimeQuerySnapshot>()
    Firestore.firestore()
      .collection(reference.referencePath)
      .addSnapshotListener(includeMetadataChanges: includeMetadata) { snapshot, error in
        if let error = error {
          changesSubject.onError(error)
        } else {
          snapshot.map { changesSubject.onNext($0) }
        }
      }
    
    return changesSubject.asObservable()
  }
  
  public func documentObservable(
    for reference: DocumentReferenceConvertible,
    includeMetadata: Bool
  ) -> Observable<iTimeDocumentSnapshot> {
    let changesSubject = PublishSubject<iTimeDocumentSnapshot>()
    Firestore.firestore()
      .document(reference.referencePath)
      .addSnapshotListener(includeMetadataChanges: includeMetadata) { snapshot, error in
        if let error = error {
          changesSubject.onError(error)
        } else {
          snapshot.map { changesSubject.onNext($0) }
        }
      }
    return changesSubject.asObservable()
  }
  
  public init() {}
}
