//
//  BookmarkListBuilder.swift
//  
//
//  Created by 이상헌 on 12/10/23.
//

import RIBs

import Start

// MARK: - BookmarkListDependency

public protocol BookmarkListDependency: Dependency {
  
}

// MARK: - BookmarkListComponent

final class BookmarkListComponent: Component<BookmarkListDependency> {
  
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
    let viewController = BookmarkListViewController()
    let interactor = BookmarkListInteractor(presenter: viewController)
    interactor.listener = listener
    return BookmarkListRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
