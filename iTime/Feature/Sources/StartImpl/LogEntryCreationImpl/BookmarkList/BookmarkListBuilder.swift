//
//  BookmarkListBuilder.swift
//  
//
//  Created by 이상헌 on 12/10/23.
//

import RIBs

import Editor
import Start

// MARK: - BookmarkListDependency

public protocol BookmarkListDependency: Dependency {
  var bookmarkEditorBuilder: BookmarkEditorBuildable { get }
}

// MARK: - BookmarkListComponent

final class BookmarkListComponent:
  Component<BookmarkListDependency>,
  BookmarkListRouterDependency
{
  
  var viewController: BookmarkListViewControllable & BookmarkListPresentable {
    BookmarkListViewController()
  }
  
  var interactor: BookmarkListInteractable {
    BookmarkListInteractor(presenter: viewController)
  }
  
  var bookmarkEditorBuilder: BookmarkEditorBuildable {
    dependency.bookmarkEditorBuilder
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
  
  public func build(withListener listener: BookmarkListListener) -> BookmarkListRouting {
    let component = BookmarkListComponent(dependency: dependency)
    return BookmarkListRouter(component)
  }
}
