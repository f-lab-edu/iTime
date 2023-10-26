//
//  AppComponent.swift
//  iTime
//
//  Created by 이상헌 on 2023/10/26.
//

import NeedleFoundation

import LoggedOut
import LoggedOutImpl
import Platform

// MARK: - AppComponent

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

// MARK: - Private

extension AppComponent {
    private var firebaseAppleAuthenticationRepository: FirebaseAppleAuthenticationRepository {
        FirebaseAppleAuthenticationRepositoryImpl()
    }
}
