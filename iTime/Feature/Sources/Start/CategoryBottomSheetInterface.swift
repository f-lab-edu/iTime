//
//  CategoryBottomSheetInterface.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import RIBs

// MARK: - CategoryBottomSheetBuildable

public protocol CategoryBottomSheetBuildable: Buildable {
    func build(withListener listener: CategoryBottomSheetListener) -> CategoryBottomSheetRouting
}

// MARK: - CategoryBottomSheetRouting

public protocol CategoryBottomSheetRouting: ViewableRouting {
}

// MARK: - CategoryBottomSheetListener

public protocol CategoryBottomSheetListener: AnyObject {
}

