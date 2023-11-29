//
//  AppComponent.swift
//  iTime
//
//  Created by 이상헌 on 2023/10/26.
//

import UIKit

import RIBs

import AppRoot
import AppRootImpl
import LoggedOut
import LoggedOutImpl
import LoggedIn
import LoggedInImpl
import Start
import StartImpl
import Editor
import EditorImpl
import Usecase
import UsecaseImpl
import Repository
import RepositoryImpl
import AppFoundation

// MARK: - AppComponent

final class AppComponent:
  Component<EmptyDependency>,
  AppRootDependency,
  LoggedOutDependency,
  LoggedInDependency,
  StartDependency,
  BookmarkEditorDependency,
  LogEntryEditorDependency,
  CategoryEditorDependency
{
  
  init() {
    super.init(dependency: EmptyComponent())
  }
  
  var categoryEditorBuilder: CategoryEditorBuildable {
    CategoryEditorBuilder(dependency: self)
  }
  
  var logEntryEditorBuilder: LogEntryEditorBuildable {
    LogEntryEditorBuilder(dependency: self)
  }
  
  var startBuilder: StartBuildable {
    StartBuilder(dependency: self)
  }
  
  var bookmarkEditorBuilder: BookmarkEditorBuildable {
    BookmarkEditorBuilder(dependency: self)
  }
  
  var loggedInBuilder: LoggedInBuildable {
    LoggedInBuilder(dependency: self)
  }
  
  var loggedOutBuilder: LoggedOutBuildable {
    LoggedOutBuilder(dependency: self)
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
  
  var authorizationContextProvider: AuthorizationContextProviding {
    UIApplication.shared
  }
}
