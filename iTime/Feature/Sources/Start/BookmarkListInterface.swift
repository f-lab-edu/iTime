//
//  BookmarkListInterface.swift
//  
//
//  Created by 이상헌 on 12/10/23.
//

import RIBs

// MARK: - BookmarkListBuildable

public protocol BookmarkListBuildable: Buildable {
    func build(withListener listener: BookmarkListListener) -> BookmarkListRouting
}

// MARK: - BookmarkListRouting

public protocol BookmarkListRouting: ViewableRouting {

}

// MARK: - BookmarkListListener

public protocol BookmarkListListener: AnyObject {
}

