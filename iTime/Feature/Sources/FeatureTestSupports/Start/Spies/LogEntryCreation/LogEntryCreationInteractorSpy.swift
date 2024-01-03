//
//  File.swift
//  
//
//  Created by 이상헌 on 11/18/23.
//

import Foundation

import RxSwift
import RIBs

import Start
import Entities
import RIBsTestSupport

@testable import StartImpl

public final class LogEntryCreationInteratableSpy: LogEntryCreationInteractable {
  
  public var didTapTagCellCallCount: Int = 0
  public var didTapTagCellBookmark: Bookmark = .empty
  public func didTapTagCell(_ bookmark: Bookmark) {
    didTapTagCellCallCount += 1
    didTapTagCellBookmark = bookmark
  }
  
  public var detachLogEntryEditorRIBCallCount: Int = 0
  public func detachLogEntryEditorRIB() {
    detachLogEntryEditorRIBCallCount += 1
  }
  
  public var detachTimeLogRunningRIBCallCount: Int = 0
  public func detachTimeLogRunningRIB() {
    detachTimeLogRunningRIBCallCount += 1
  }
  
  public var detachBookmarkEditorRIBCallCount: Int = 0
  public func detachBookmarkEditorRIB() {
    detachBookmarkEditorRIBCallCount += 1
  }
  
  public var attachTimeLogRunningRIBCallCount: Int = 0
  public func attachTimeLogRunningRIB() {
    attachTimeLogRunningRIBCallCount += 1
  }
  
  public var routerSetCallCount: Int = 0
  public var router: LogEntryCreationRouting? { didSet { self.routerSetCallCount += 1 }} 
  public var listenerSetCallCount: Int = 0
  public var listener: LogEntryCreationListener? { didSet { self.listenerSetCallCount += 1 }}
  
  public var activateCallCount: Int = 0
  public func activate() {
    activateCallCount += 1
  }
  
  public var deactivateCallCount: Int = 0
  public func deactivate() {
    deactivateCallCount += 1
  }
  
  public var isActive: Bool { (try? isActiveSubject.value()) ?? false }
  
  public var isActiveStream: Observable<Bool> { isActiveSubject.asObservable()}
  
  private let isActiveSubject = BehaviorSubject<Bool>(value: false)
  
  public init() {}
}

public final class LogEntryCreationViewControllableSpy:
  ViewControllableMock,
  LogEntryCreationViewControllable
{
  public var addBookmarkListCallCount: Int = 0
  public func addBookmarkList(_ view: RIBs.ViewControllable) {
   addBookmarkListCallCount += 1
  }
  
  public var addLoggingRetentionCallCount: Int = 0
  public func addLoggingRetention(_ view: RIBs.ViewControllable) {
   addLoggingRetentionCallCount += 1
  }
}

