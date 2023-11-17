//
//  BookmarkEditorBuilder.swift
//  
//
//  Created by 이상헌 on 11/14/23.
//

import RIBs

import Start

// MARK: - BookmarkEditorDependency

public protocol BookmarkEditorDependency: Dependency {
  
}

// MARK: - BookmarkEditorComponent

final class BookmarkEditorComponent: Component<BookmarkEditorDependency> {
  
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
    let interactor = BookmarkEditorInteractor(presenter: viewController)
    interactor.listener = listener
    return BookmarkEditorRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}