//
//  ColorPickerInterface.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs

// MARK: - ColorPickerBuildable

public protocol ColorPickerBuildable: Buildable {
    func build(withListener listener: ColorPickerListener) -> ColorPickerRouting
}

// MARK: - ColorPickerRouting

public protocol ColorPickerRouting: ViewableRouting {
}

// MARK: - ColorPickerListener

public protocol ColorPickerListener: AnyObject {
}

