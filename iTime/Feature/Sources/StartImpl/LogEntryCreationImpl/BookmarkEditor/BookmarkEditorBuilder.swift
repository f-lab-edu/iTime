//
//  BookmarkEditorBuilder.swift
//  
//
//  Created by 이상헌 on 11/14/23.
//

import RIBs

import Start
import BookmarkUsecase

// MARK: - BookmarkEditorDependency

public protocol BookmarkEditorDependency: Dependency {
  var bookmarkUsecase: BookmarkUsecase { get }
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
    let _ = BookmarkEditorComponent(dependency: dependency)
    let viewController = BookmarkEditorViewController()
    let interactor = BookmarkEditorInteractor(
      presenter: viewController,
      bookmarkUsecase: dependency.bookmarkUsecase
    )
    interactor.listener = listener
    return BookmarkEditorRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
