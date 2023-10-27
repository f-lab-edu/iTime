//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/27.
//

import FirebaseFirestore

// Firebase SDK 의존성을 감추기 위해

// MARK: - DocumentSnapshotWrapper

public final class DocumentSnapshotWrapper {
    private let documentSnapshot: DocumentSnapshot
    
    public init(documentSnapshot: DocumentSnapshot) {
        self.documentSnapshot = documentSnapshot
    }
}

// MARK: - QuerySnapshotWrapper

public final class QuerySnapshotWrapper {
    private let querySnapshot: QuerySnapshot
    
    public init(querySnapshot: QuerySnapshot) {
        self.querySnapshot = querySnapshot
    }
}


