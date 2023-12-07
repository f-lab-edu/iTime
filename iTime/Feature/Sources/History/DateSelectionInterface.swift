//
//  DateSelectionInterface.swift
//  
//
//  Created by 이상헌 on 12/7/23.
//

import RIBs

// MARK: - DateSelectionBuildable

public protocol DateSelectionBuildable: Buildable {
    func build(withListener listener: DateSelectionListener) -> DateSelectionRouting
}

// MARK: - DateSelectionRouting

public protocol DateSelectionRouting: ViewableRouting {
}

// MARK: - DateSelectionListener

public protocol DateSelectionListener: AnyObject {
}

