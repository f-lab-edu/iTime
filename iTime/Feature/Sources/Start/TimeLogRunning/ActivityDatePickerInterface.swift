//
//  ActivityDatePickerInterface.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import RIBs

// MARK: - ActivityDatePickerBuildable

public protocol ActivityDatePickerBuildable: Buildable {
    func build(withListener listener: ActivityDatePickerListener) -> ActivityDatePickerRouting
}

// MARK: - ActivityDatePickerRouting

public protocol ActivityDatePickerRouting: ViewableRouting {
}

// MARK: - ActivityDatePickerListener

public protocol ActivityDatePickerListener: AnyObject {
}

