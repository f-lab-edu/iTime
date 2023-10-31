//
//  AppComponent.swift
//  iTime
//
//  Created by 이상헌 on 2023/10/26.
//

import RIBs

// MARK: - AppComponent

final class AppComponent:
    Component<EmptyDependency>,
    AppRootDependency
{
    init() {
        super.init(dependency: EmptyComponent())
    }

}
