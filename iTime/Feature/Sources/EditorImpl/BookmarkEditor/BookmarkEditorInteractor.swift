//
//  BookmarkEditorInteractor.swift
//
//
//  Created by 이상헌 on 11/14/23.
//
import Foundation

import RIBs
import RxSwift


import Editor
import Usecase
import Entities
import AppFoundation

// MARK: - BookmarkEditorPresentable

protocol BookmarkEditorPresentable: Presentable {
  var listener: BookmarkEditorPresentableListener? { get set }
  func presentError(_ error: DisplayErrorMessage)
}

// MARK: - BookmarkEditorInteractor

final class BookmarkEditorInteractor:
  PresentableInteractor<BookmarkEditorPresentable>,
  BookmarkEditorInteractable,
  BookmarkEditorPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: BookmarkEditorRouting?
  weak var listener: BookmarkEditorListener?
  private let editorUsecase: EditorUsecase
  
  // MARK: - Initialization & DeInitialization
  
  init(
    presenter: BookmarkEditorPresentable,
    editorUsecase: EditorUsecase
  ) {
    self.editorUsecase = editorUsecase
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - Mutation
  
  func didTapSaveButton() {
    editorUsecase.uploadBookmarks()
      .catch ({ [weak self] error in
        guard let self else { return .never() }
        self.presenter.presentError(self.saveButtonErrorMessage(error.localizedDescription))
        return .never()
      })
      .debug("save button Test")
      .subscribe()
      .disposeOnDeactivate(interactor: self)
  }
  
  func didTapAddButton() {
    
  }
  
  func didTapBackButton() {
    listener?.detachBookmarkEditorRIB()
  }
  
  func didTapTagCell(at index: IndexPath) {
    
  }
  
  // MARK: - Private
  
  private func saveButtonErrorMessage(_ message: String) -> DisplayErrorMessage {
    return DisplayErrorMessage(
      title: "Save button Error",
      message: message,
      confirmActionTitle: "Confirm"
    )
  }
  
}
