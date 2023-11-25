//
//  AppRootBuilder.swift
//  iTime
//
//  Created by 이상헌 on 2023/10/26.
//

import UIKit

import RIBs

import LoggedOut
import LoggedOutImpl
import LoggedIn
import LoggedInImpl
import Start
import StartImpl
import Editor
import EditorImpl
import AuthenticationUsecase
import AuthenticationUsecaseImpl
import BookmarkUsecase
import BookmarkUsecaseImpl
import NetworkRepositoryImpl
import AppFoundation

protocol AppRootDependency: Dependency {
  
}

final class AppRootComponent:
  Component<AppRootDependency>,
  LoggedOutDependency,
  LoggedInDependency,
  StartDependency,
  BookmarkEditorDependency,
  LogEntryEditorDependency,
  CategoryEditorDependency
{
  var categoryEditorBuilder: CategoryEditorBuildable {
    CategoryEditorBuilder(dependency: self)
  }
  
  var logEntryEditorBuilder: LogEntryEditorBuildable {
    LogEntryEditorBuilder(dependency: self)
  }
  
  var bookmarkUsecase: BookmarkUsecase {
    shared {
      BookmarkUsecaseImpl(bookmarkRepository: 2)
    }
  }
  
  var authenticationUsecase: AuthenticationUsecase {
    shared {
      AuthenticationUsecaseImpl(
        appleAuthenticationRepository: AppleAuthenticationRepositoryImpl(), authorizationContextProvider: authorizationContextProvider
      )
    }
  }
  
  var startBuilder: StartBuildable {
    StartBuilder(dependency: self)
  }
  
  var bookmarkEditorBuilder: BookmarkEditorBuildable {
    BookmarkEditorBuilder(dependency: self)
  }
  
  var authorizationContextProvider: AuthorizationContextProviding {
    UIApplication.shared
  }
  
}

// MARK: - Builder

protocol AppRootBuildable: Buildable {
  func build() -> LaunchRouting
}

final class AppRootBuilder:
  Builder<AppRootDependency>,
  AppRootBuildable
{
  override init(dependency: AppRootDependency) {
    super.init(dependency: dependency)
  }
  
  func build() -> LaunchRouting {
    let viewController = AppRootViewController()
    let component = AppRootComponent(dependency: dependency)
    let interactor = AppRootInteractor(
      presenter: viewController,
      authenticationUsecase: component.authenticationUsecase
    )
    let loggedOutBuilder = LoggedOutBuilder(dependency: component)
    let loggedInBuilder = LoggedInBuilder(dependency: component)
    
    return AppRootRouter(
      interactor: interactor,
      viewController: viewController,
      loggedOutBuilder: loggedOutBuilder,
      loggedInBuilder: loggedInBuilder
    )
  }
}

