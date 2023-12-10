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
  var mutableBookmarkModelDataStream: MutableBookmarkModelDataStream { get }
  var bookmarkListBuilder: BookmarkListBuildable { get }
}

// MARK: - BookmarkEditorComponent

final class BookmarkEditorComponent: 
  Component<BookmarkEditorDependency>,
  ActivityHistoryDependency
{
  
  fileprivate var activityHistoryBuilder: ActivityHistoryBuildable {
      ActivityHistoryBuilder(dependency: self)
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
      mutableBookmarkModelDataStream: dependency.mutableBookmarkModelDataStream 
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
