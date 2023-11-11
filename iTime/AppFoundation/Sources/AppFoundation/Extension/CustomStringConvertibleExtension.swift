//
//  CustomStringConvertibleExtension.swift
//  TaxiDispatch
//
//  Created by sangheon on 2023/08/22.
//

import Foundation

public extension CustomStringConvertible {
    var description: String {
        var description = "\n**** \(type(of: self))) *****\n"
        let selfMirror = Mirror(reflecting: self)
        for child in selfMirror.children {
            if let propertyName = child.label {
                description += "\(propertyName): \(child.value)\n"
            }
        }
        return description
    }
}
