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
import BaseRepository
import Translator
import Entities
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
  CategoryEditorDependency,
  BookmarkListDependency,
  TimeLogRunningDependency,
  LoggingRetentionDependency,
  LogEntryCreationDependency,
  CurrentTimerTimeDependency,
  ActivityDatePickerDependency,
  TimerOperationDependency,
  CurrentActivityDependency
{
  var logEntryCreationBuilder: LogEntryCreationBuildable {
    LogEntryCreationBuilder(dependency: self)
  }
  
  var currentActivityBuilder: CurrentActivityBuildable {
    CurrentActivityBuilder(dependency: self)
  }
  
  var currentTimerTimeBuilder: CurrentTimerTimeBuildable {
    CurrentTimerTimeBuilder(dependency: self)
  }
  
  var activityDatePickerBuilder: ActivityDatePickerBuildable {
    ActivityDatePickerBuilder(dependency: self)
  }
  
  var timerOperationBuilder: TimerOperationBuildable {
    TimerOperationBuilder(dependency: self)
  }
  
  var timeLogRunningBuilder: TimeLogRunningBuildable {
    TimeLogRunningBuilder(dependency: self)
  }
  
  var loggingRetentionBuilder: LoggingRetentionBuildable {
    LoggingRetentionBuilder(dependency: self)
  }
  
  var bookmarkListBuilder: BookmarkListBuildable {
    BookmarkListBuilder(dependency: self)
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
  
  init() {
    let firestoreRepository = FirestoreRepositoryImpl()
    let userDefaultRepository = UserDefaultRepositoryImpl()
    let bookmarkRepository = BookmarkRepositoryImpl(
      firestoreRepository: firestoreRepository,
      userDefaultRepository: userDefaultRepository,
      translator: BookmarkTranslator()
    )
    let timeLogRecordRepository = TimeLogRecordRepositoryImpl(
      firestoreRepository: firestoreRepository,
      userDefaultRepository: userDefaultRepository,
      translator: TimeLogRecordTranslator()
    )
    self.bookmarkModelDataStream = BookmarkModelDataStream()
    self.timeLogRecordModelDataStream = TimeLogRecordModelDataStream()
    
    let firebaseAnalyticsLogger = FirebaseAnalyticsLoggerImpl(
      userID: userDefaultRepository.userID
    )
    
    let timeLogUsecase = TimeLogUsecaseImpl(
      bookmarkRepository: bookmarkRepository,
      timeLogRecordRepository: timeLogRecordRepository,
      bookmarkModelDataStream: bookmarkModelDataStream,
      timeLogRecordModelDataStream: timeLogRecordModelDataStream
    )
    
    self.timeLogUsecase = TimeLogUsecaseMonitoringDecorator(
      decoratee: timeLogUsecase,
      logger: firebaseAnalyticsLogger
    )
    
    self.authenticationUsecase = AuthenticationUsecaseImpl(
      appleAuthenticationRepository: AppleAuthenticationRepositoryImpl(),
      authorizationContextProvider: UIApplication.shared
    )
    
    super.init(dependency: EmptyComponent())
  }
  
  let timeLogUsecase: TimeLogUsecase
  
  let authenticationUsecase: AuthenticationUsecase
  
  let bookmarkModelDataStream: BookmarkModelDataStream
  
  let timeLogRecordModelDataStream: TimeLogRecordModelDataStream
  
  var timeFormatter = TimeFormatter()
}

