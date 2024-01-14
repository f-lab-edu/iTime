//
//  File.swift
//
//
//  Created by 이상헌 on 2023/10/27.
//

import FirebaseFirestore
import RxSwift

import BaseRepository
import Repository

// MARK: - FirestoreRepository Implemetation

public final class FirestoreRepositoryImpl: FirestoreRepository {
  
  private let firestore: iTimeFirestore
  
  public init(firestore: iTimeFirestore) {
    self.firestore = firestore
  }
  
  public func create(
    reference: DocumentReferenceConvertible,
    with data: [String : Any]
  ) -> Observable<String> {
    Observable.create(with: self) { owner, observer in
      let document = owner.firestore.iTimeCollection(reference.referencePath).document()
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
    Observable.create(with: self) { owner, observer in
      let document = owner.firestore.iTimeDocument(reference.referencePath)
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
    firestore
      .iTimeCollection(reference.referencePath)
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
    firestore
      .iTimeDocument(reference.referencePath)
      .addSnapshotListener(includeMetadataChanges: includeMetadata) { snapshot, error in
        if let error = error {
          changesSubject.onError(error)
        } else {
          snapshot.map { changesSubject.onNext($0) }
        }
      }
    return changesSubject.asObservable()
  }
}
