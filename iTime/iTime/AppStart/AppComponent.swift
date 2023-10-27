//
//  AppComponent.swift
//  iTime
//
//  Created by 이상헌 on 2023/10/26.
//

import NeedleFoundation

import Platform
import PlatformImpl
import Domain
import DomainImpl
import LoggedOut
import LoggedOutImpl


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
    
    var authenticationUsecase: AuthenticationUsecase {
        AuthenticationUsecaseImpl(appleAuthenticationRepository: firebaseAppleAuthenticationRepository)
    }

}

// MARK: - Private

extension AppComponent {
    private var firebaseAppleAuthenticationRepository: FirebaseAppleAuthenticationRepository {
        return FirebaseAppleAuthenticationRepositoryImpl()
    }
}
