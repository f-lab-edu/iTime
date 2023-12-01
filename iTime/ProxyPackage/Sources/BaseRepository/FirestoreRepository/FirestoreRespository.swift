//
//  FireStoreManager.swift
//  iTime
//
//  Created by 이상헌 on 2023/10/24.
//

import RxSwift

// MARK: - FirestoreRepository

public protocol FirestoreRepository {
    /// Create new document
    ///
    /// - Parameter data: Data serialized to [String: Any] format
    /// - Parameter reference: enumerated doc reference
    /// - Parameter merge: merge with current session data or overwrite
    func create(
        reference: DocumentReferenceConvertible,
        with data: [String: Any]
    ) -> Observable<String>
    
    /// Updating existing document
    ///
    /// - Parameter data: Data serialized to [String: Any] format
    /// - Parameter reference: enumerated doc reference
    /// - Parameter merge: merge with current session data or overwrite
    func update(
        reference: DocumentReferenceConvertible,
        with data: [String: Any],
        merge: Bool
    ) -> Observable<String>
    
    /// Observable for collections in Firebase
    ///
    /// - Parameters:
    ///   - reference: Reference to a document in Firebase database
    ///   - includeMetadataChanges: ability to listen also for changes in metadata
    func collectionObservable(
        for reference: DocumentReferenceConvertible,
        includeMetadata: Bool
    ) -> Observable<iTimeQuerySnapshot>
    
    /// Observable for documents in Firebase
    ///
    /// - Parameters:
    ///   - reference: Reference to a document in Firebase database
    ///   - includeMetadataChanges: ability to listen also for changes in metadata
    func documentObservable(
        for reference: DocumentReferenceConvertible,
        includeMetadata: Bool
    ) -> Observable<iTimeDocumentSnapshot>
}
