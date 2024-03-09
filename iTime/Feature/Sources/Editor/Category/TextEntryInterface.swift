//
//  TextEntryInterface.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs

// MARK: - TextEntryBuildable

public protocol TextEntryBuildable: Buildable {
    func build(withListener listener: TextEntryListener) -> TextEntryRouting
}

// MARK: - TextEntryRouting

public protocol TextEntryRouting: ViewableRouting {
}

// MARK: - TextEntryListener

public protocol TextEntryListener: AnyObject {
  func currentCategoryTitle(with title: String)
}

