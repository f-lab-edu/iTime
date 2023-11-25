//
//  CategoryEditorInterface.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import RIBs

// MARK: - CategoryEditorBuildable

public protocol CategoryEditorBuildable: Buildable {
    func build(withListener listener: CategoryEditorListener) -> CategoryEditorRouting
}

// MARK: - CategoryEditorRouting

public protocol CategoryEditorRouting: ViewableRouting {
}

// MARK: - CategoryEditorListener

public protocol CategoryEditorListener: AnyObject {
}

