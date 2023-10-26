//
//  AppComponent.swift
//  iTime
//
//  Created by 이상헌 on 2023/10/26.
//

import Foundation

import NeedleFoundation

final class AppComponent:
    BootstrapComponent,
    AppRootDependency
{
    var appRootBuilder: AppRootBuildable {
        AppRootBuilder {
            AppRootComponent(parent: self)
        }
    }
}
