//
//  AppComponent.swift
//  iTime
//
//  Created by 이상헌 on 2023/10/26.
//

import UIKit
import CoreLocation

import RIBs
import Clocks
import FirebaseFirestore

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
  CurrentActivityDependency,
  CategoryListDependency, 
  CategoryCreationDependency,
  TextEntryDependency,
  ColorPickerDependency
{
  var textEntryBuilder: TextEntryBuildable {
    TextEntryBuilder(dependency: self)
  }
  
  var colorPickerBuilder: ColorPickerBuildable {
    ColorPickerBuilder(dependency: self)
  }
  
  var categoryCreationBuilder: CategoryCreationBuilder {
    CategoryCreationBuilder(dependency: self)
  }
  
  var categoryListBuilder: CategoryListBuildable {
    CategoryListBuilder(dependency: self)
  }
  
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
    let firestoreRepository = FirestoreRepositoryImpl(firestore: Firestore.firestore())
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
    self.activityLogModelStream = ActivityLogModelStream()
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
      authorizationContextProvider: UIApplication.shared, 
      userDefaultRepository: userDefaultRepository
    )
    
    let locationTracker = LocationTrackerImpl(
      applicationShared: UIApplication.shared,
      locationFetcher: CLLocationManager()
    )
    let runningTimeTracker = RunningTimeTrackerImpl(timer: ContinuousClock())
    self.timerInfoModelDataStream = TimerInfoModelDataStream()
    
    let timeLogRecordBuilder = TimeLogRecordBuilder(
      locationTracker: locationTracker,
      runningTimeTracker: runningTimeTracker,
      timerInfoModelDataStream: timerInfoModelDataStream
    )

    let timeStartFacade = TimeStartFacadeImpl(
      locationTracker: locationTracker,
      runningTimeTracker: runningTimeTracker,
      timerInfoModelDataStream: timerInfoModelDataStream,
      userDefaultRepository: userDefaultRepository
    )
    
    let timeSuspenseFacade = TimeSuspenseFacadeImpl(
      runningTimeTracker: runningTimeTracker,
      locationTracker: locationTracker
    )
    
    let timeFinishFacade = TimeFinishFacadeImpl(
      locationTracker: locationTracker,
      runningTimeTracker: runningTimeTracker,
      timeLogRecordRepository: timeLogRecordRepository,
      timeLogRecordModelDataStream: timeLogRecordModelDataStream
    )
    
    self.timerUsecase = TimerUsecaseImpl(
      timeLogRecordBuilder: timeLogRecordBuilder,
      timeStartFacade: timeStartFacade,
      timeSuspenseFacade: timeSuspenseFacade,
      timeFinishFacade: timeFinishFacade
    )
    
    self.editorUsecase = EditorUsecaseImpl(
      bookmarkModelDataStream: bookmarkModelDataStream,
      timeLogRecordModelDataStream: timeLogRecordModelDataStream,
      bookmarkRepository: bookmarkRepository,
      timeLogRecordRepository: timeLogRecordRepository
    )
    
    super.init(dependency: EmptyComponent())
  }
  
  let timeLogUsecase: TimeLogUsecase
  
  let timerUsecase: TimerUsecase
  
  let authenticationUsecase: AuthenticationUsecase
  
  let timerInfoModelDataStream: TimerInfoModelDataStream
  
  let editorUsecase: EditorUsecase
  
  let bookmarkModelDataStream: BookmarkModelDataStream
  
  let timeLogRecordModelDataStream: TimeLogRecordModelDataStream
  
  let activityLogModelStream: ActivityLogModelStream
  
  let timeFormatter = TimeFormatter()
}

