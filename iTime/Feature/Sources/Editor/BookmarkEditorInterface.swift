//
//  BookmarkEditorInterface.swift
//  
//
//  Created by 이상헌 on 11/16/23.
//

import RIBs

// MARK: - BookmarkEditorBuildable

public protocol BookmarkEditorBuildable: Buildable {
    func build(withListener listener: BookmarkEditorListener) -> BookmarkEditorRouting
}

// MARK: - BookmarkEditorRouting

public protocol BookmarkEditorRouting: ViewableRouting {
}

// MARK: - BookmarkEditorListener

public protocol BookmarkEditorListener: AnyObject {
}

