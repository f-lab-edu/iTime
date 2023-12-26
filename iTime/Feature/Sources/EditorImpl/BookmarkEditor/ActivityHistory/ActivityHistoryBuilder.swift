//
//  ActivityHistoryBuilder.swift
//  
//
//  Created by 이상헌 on 12/10/23.
//

import RIBs

import Entities
import Editor

// MARK: - ActivityHistoryDependency

public protocol ActivityHistoryDependency: Dependency {
  var timeLogRecordModelDataStream: TimeLogRecordModelDataStream { get }
  var bookmarkModelDataStream: BookmarkModelDataStream { get }
}

// MARK: - ActivityHistoryComponent

final class ActivityHistoryComponent: Component<ActivityHistoryDependency> {
  fileprivate let initialState: ActivityHistoryModel.State = .init()
  
  fileprivate var timeLogRecordModelDataStream: TimeLogRecordModelDataStream {
    dependency.timeLogRecordModelDataStream
  }
  
  fileprivate var bookmarkModelDataStream: BookmarkModelDataStream {
    dependency.bookmarkModelDataStream
  }
}

// MARK: - ActivityHistoryBuilder

public final class ActivityHistoryBuilder:
  Builder<ActivityHistoryDependency>,
  ActivityHistoryBuildable
{
  
  public override init(dependency: ActivityHistoryDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: ActivityHistoryListener) -> ActivityHistoryRouting {
    let component = ActivityHistoryComponent(dependency: dependency)
    let viewController = ActivityHistoryViewController()
    let interactor = ActivityHistoryInteractor(
      initialState: component.initialState,
      presenter: viewController,
      timeLogRecordModelDataStream: component.timeLogRecordModelDataStream,
      bookmarkModelDataStream: component.bookmarkModelDataStream
    )
    interactor.listener = listener
    return ActivityHistoryRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
