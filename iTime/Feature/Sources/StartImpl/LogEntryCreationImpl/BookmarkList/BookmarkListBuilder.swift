//
//  BookmarkListBuilder.swift
//  
//
//  Created by 이상헌 on 12/10/23.
//

import RIBs

import Editor
import Start

import Entities
import AppFoundation

// MARK: - BookmarkListDependency

public protocol BookmarkListDependency: Dependency {
  var bookmarkModelDataStream: BookmarkModelDataStream { get }
}

// MARK: - BookmarkListComponent

final class BookmarkListComponent: Component<BookmarkListDependency> {
  var initalState: BookmarkListModel.State = .init()
  
  var bookmarkModelDataStream: BookmarkModelDataStream {
    dependency.bookmarkModelDataStream
  }
}

// MARK: - BookmarkListBuilder

public final class BookmarkListBuilder:
  Builder<BookmarkListDependency>,
  BookmarkListBuildable
{

  public override init(dependency: BookmarkListDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(
    withListener listener: BookmarkListListener,
    payload: BookmarkListBuildDependency
  ) -> BookmarkListRouting {
    let component = BookmarkListComponent(dependency: dependency)
    let viewController = BookmarkListViewController(
      alignedCollectionViewFlowLayout: payload.alignedCollectionViewFlowLayout,
      cellBorderColor: payload.borderColor.innerColor,
      emptyLabelText: payload.emptyLabel, 
      emptyTextAlignment: payload.emptyTextAlignment
    )
    let interactor = BookmarkListInteractor(
      presenter: viewController,
      bookmarkModelDataStream: component.bookmarkModelDataStream
    )
    interactor.listener = listener
    return BookmarkListRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
