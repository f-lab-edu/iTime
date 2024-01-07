//
//  Reusable.swift
//  RibsReactorkitClone
//
//  Created by sangheon on 2023/04/19.
//

import Foundation

public protocol Reusable {
    static var identifier: String { get }
}

extension Reusable {
    public static var identifier: String {
        String(describing: Self.self)
    }
}
