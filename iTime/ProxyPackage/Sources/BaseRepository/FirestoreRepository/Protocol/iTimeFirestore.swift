//
//  File.swift
//  
//
//  Created by 이상헌 on 1/9/24.
//

import FirebaseFirestore

// MARK: - iTimeFirestore

public protocol iTimeFirestore {
  func iTimeCollection(_ collectionPath: String) -> iTimeColletionReference
  func iTimeDocument(_ documentPath: String) -> iTimeDocumentReference
}

// MARK: - FirebaseFirestore

extension Firestore: iTimeFirestore {
  public func iTimeCollection(_ collectionPath: String) -> iTimeColletionReference {
    self.collection(collectionPath)
  }
  
  public func iTimeDocument(_ documentPath: String) -> iTimeDocumentReference {
    self.document(documentPath)
  }
}

extension CollectionReference: iTimeColletionReference {}
extension DocumentReference: iTimeDocumentReference {}

// MARK: - iTimeColletionReference

public protocol iTimeColletionReference {
  func document() -> DocumentReference
  @discardableResult
  func addSnapshotListener(
    includeMetadataChanges: Bool,
    listener: @escaping (QuerySnapshot?, Error?) -> Void
  ) -> ListenerRegistration
}

// MARK: - iTimeDocumentReference

public protocol iTimeDocumentReference {
  var documentID: String { get }
  func setData(_ documentData: [String: Any], merge: Bool, completion: ((Error?) -> Void)?)
  @discardableResult
  func addSnapshotListener(
    includeMetadataChanges: Bool,
    listener: @escaping (DocumentSnapshot?, Error?) -> Void
  ) -> ListenerRegistration
}
