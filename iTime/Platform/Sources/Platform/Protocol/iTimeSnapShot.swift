//
//  File.swift
//  
//
//  Created by 이상헌 on 2023/10/27.
//

// MARK: - iTimeDocumentSnapshot

public protocol iTimeDocumentSnapshot {
    var documentID: String { get }
    func data() -> Dictionary<String, Any>?
}

// MARK: - iTimeQuerySnapshot

public protocol iTimeQuerySnapshot {
    var iTimeDocuments: [iTimeDocumentSnapshot] { get }
}


