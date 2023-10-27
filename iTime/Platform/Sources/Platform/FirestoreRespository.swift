//
//  FireStoreManager.swift
//  iTime
//
//  Created by 이상헌 on 2023/10/24.
//

import RxSwift

// MARK: - FirestoreRepository

public protocol FirestoreRepository {
    func create(
        reference: DocumentReferenceConvertible,
        with data: [String: Any]
    ) -> Observable<String>
    
    func update(
        reference: DocumentReferenceConvertible,
        with data: [String: Any],
        merge: Bool
    ) -> Observable<String>
    
    func collectionObservable(
        for reference: DocumentReferenceConvertible,
        includeMetadata: Bool
    ) -> Observable<QuerySnapshotWrapper>
    
    func documentObservable(
        for reference: DocumentReferenceConvertible,
        includeMetadata: Bool
    ) -> Observable<DocumentSnapshotWrapper>
}
