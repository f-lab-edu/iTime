//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/25.
//

import Foundation

// MARK: - FireStoreUserRepository

protocol FireStoreUserRepository {
    
}

// MARK: - FireStoreUserRepositoryImpl

final class FireStoreUserRepositoryImpl: FireStoreUserRepository {
    
    private let firestoreRepository: FirestoreRepository
    
    public init(firestoreRepository: FirestoreRepository) {
        self.firestoreRepository = firestoreRepository
    }
    
}
