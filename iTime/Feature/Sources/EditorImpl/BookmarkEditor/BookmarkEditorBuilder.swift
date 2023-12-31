//
//  BookmarkEditorBuilder.swift
//  
//
//  Created by 이상헌 on 11/14/23.
//

import RIBs

import Entities
import Start
import Editor
import Usecase
import SharedUI

// MARK: - BookmarkEditorDependency

public protocol BookmarkEditorDependency: Dependency {
  var bookmarkModelDataStream: BookmarkModelDataStream { get }
  var bookmarkListBuilder: BookmarkListBuildable { get }
  var timeLogRecordModelDataStream: TimeLogRecordModelDataStream { get }
  var editorUsecase: EditorUsecase { get }
}

// MARK: - BookmarkEditorComponent

final class BookmarkEditorComponent: 
  Component<BookmarkEditorDependency>,
  ActivityHistoryDependency
{
  var bookmarkModelDataStream: BookmarkModelDataStream {
    dependency.bookmarkModelDataStream
  }
  
  var timeLogRecordModelDataStream: TimeLogRecordModelDataStream {
    dependency.timeLogRecordModelDataStream
  }
  
  fileprivate var activityHistoryBuilder: ActivityHistoryBuildable {
      ActivityHistoryBuilder(dependency: self)
  }
  
  fileprivate var editorUsecase: EditorUsecase {
    dependency.editorUsecase
  }
}

// MARK: - BookmarkEditorBuilder

public final class BookmarkEditorBuilder:
  Builder<BookmarkEditorDependency>,
  BookmarkEditorBuildable
{
  
  public override init(dependency: BookmarkEditorDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: BookmarkEditorListener) -> BookmarkEditorRouting {
    let component = BookmarkEditorComponent(dependency: dependency)
    let viewController = BookmarkEditorViewController()
    let interactor = BookmarkEditorInteractor(
      presenter: viewController,
      editorUsecase: component.editorUsecase
    )
    interactor.listener = listener
    return BookmarkEditorRouter(
      interactor: interactor,
      viewController: viewController,
      bookmarkListBuilder: dependency.bookmarkListBuilder,
      activityHistoryBuilder: component.activityHistoryBuilder
    )
  }
}
