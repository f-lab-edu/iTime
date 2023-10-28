//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/27.
//

import FirebaseFirestore
import RxSwift

import Platform

// MARK: - DocumentSnapshot & QuerySnapshot

extension DocumentSnapshot: iTimeDocumentSnapshot {}

extension QuerySnapshot: iTimeQuerySnapshot {
    public var iTimeDocuments: [iTimeDocumentSnapshot] {
        self.documents
    }
}

// MARK: - FirestoreRespositoryImpl

final class FirestoreRespositoryImpl: FirestoreRepository {
    private let database: Firestore
    
    init(database: Firestore = Firestore.firestore()) {
        self.database = database
        
    }
    
    /// Create new document
    /// - Parameter data: Data serialized to [String: Any] format
    /// - Parameter reference: enumerated doc reference
    /// - Parameter merge: merge with current session data or overwrite
    func create(
        reference: DocumentReferenceConvertible,
        with data: [String : Any]
    ) -> Observable<String> {
        Observable.create { observer in
            let document = self.database.collection(reference.referencePath).document()
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
    
    /// Updating existing document
    /// - Parameter data: Data serialized to [String: Any] format
    /// - Parameter reference: enumerated doc reference
    /// - Parameter merge: merge with current session data or overwrite
    func update(
        reference: DocumentReferenceConvertible,
        with data: [String: Any],
        merge: Bool
    ) -> Observable<String> {
        Observable.create { observer in
            let document = self.database.document(reference.referencePath)
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
    
    /// Observable for collections in Firebase
    ///
    /// - Parameters:
    ///   - reference: Reference to a document in Firebase database
    ///   - includeMetadataChanges: ability to listen also for changes in metadata
    func collectionObservable(
        for reference: DocumentReferenceConvertible,
        includeMetadata: Bool
    ) -> Observable<iTimeQuerySnapshot> {
        let changesSubject = PublishSubject<iTimeQuerySnapshot>()
        database
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
    
    /// Observable for documents in Firebase
    ///
    /// - Parameters:
    ///   - reference: Reference to a document in Firebase database
    ///   - includeMetadataChanges: ability to listen also for changes in metadata
    func documentObservable(
        for reference: DocumentReferenceConvertible,
        includeMetadata: Bool
    ) -> Observable<iTimeDocumentSnapshot> {
        let changesSubject = PublishSubject<iTimeDocumentSnapshot>()
        database
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
}
