//
//  File.swift
//
//
//  Created by 이상헌 on 2023/10/27.
//

import FirebaseFirestore

// MARK: - iTimeDocumentSnapshot

public protocol iTimeDocumentSnapshot {
  var documentID: String { get }
  func data() -> Dictionary<String, Any>?
}

// MARK: - iTimeQuerySnapshot

public protocol iTimeQuerySnapshot {
  var iTimeDocuments: [iTimeDocumentSnapshot] { get }
}

// MARK: Decoder

extension iTimeDocumentSnapshot {
  public func jsonData() -> Data? {
    data().flatMap { try? JSONSerialization.data(withJSONObject: $0, options: .sortedKeys) }
  }
  
  public func decode<T: Decodable>() throws -> T? {
    guard let dataValue = data(), !dataValue.isEmpty else { return nil }
    let json = try data()
      .flatMap { try JSONSerialization.data(withJSONObject: $0, options: .sortedKeys) } ?? Data()
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970
    return try decoder.decode(T.self, from: json)
  }
}

// MARK: - DocumentSnapshot & QuerySnapshot

extension DocumentSnapshot: iTimeDocumentSnapshot {}

extension QuerySnapshot: iTimeQuerySnapshot {
  public var iTimeDocuments: [iTimeDocumentSnapshot] {
    self.documents
  }
}
