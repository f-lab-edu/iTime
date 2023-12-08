//
//  File.swift
//  
//
//  Created by 이상헌 on 12/5/23.
//

import RxSwift

import Entities
import SharedUI
import AppFoundation

// MARK: - LogEntryCreationPresentableState

 struct LogEntryCreationPresentableState {
  var bookmarks: [Bookmark] = []
  var isHiddenEncouragingBox = false
}

// MARK: - LogEntryCreationPresentableAction

enum LogEntryCreationPresentableAction {
  case loadAction
  case didTapEncouragingBox
  case didTapSettingButton
  case didTapBookmarkTagEditor
  case didTapEditorRoutingButton
  case didTapStartButton
  case didTapTagCell
  case didTapEncouragingBoxCloseButton
}

// MARK: - LogEntryCreationPresentableListener

protocol LogEntryCreationPresentableListener:
  AnyObject,
  BookmarkCollectionViewCellDelegate,
  BookmarkTagsCollectionViewAdapterDataSource
{
  typealias Action = LogEntryCreationPresentableAction
  typealias State = LogEntryCreationPresentableState
  
  func sendAction(_ action: Action)
  var state: Observable<State> { get }
}




