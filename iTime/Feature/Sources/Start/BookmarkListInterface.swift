//
//  BookmarkListInterface.swift
//  
//
//  Created by 이상헌 on 12/10/23.
//
import UIKit

import RIBs

import AppFoundation
import Entities
import SharedUI

// MARK: - BookmarkListBuildable

public protocol BookmarkListBuildable: Buildable {
  func build(
    withListener listener: BookmarkListListener,
    payload: BookmarkListBuildDependency
  ) -> BookmarkListRouting
}

public struct BookmarkListBuildDependency {
  public let alignedCollectionViewFlowLayout: AlignedCollectionViewFlowLayout
  public let borderColor: ColorWrapper
  public let emptyLabel: String
  public let emptyTextAlignment: NSTextAlignment
  
  public init(
    alignedCollectionViewFlowLayout: AlignedCollectionViewFlowLayout,
    borderColor: ColorWrapper,
    emptyLabel: String,
    emptyTextAlignment: NSTextAlignment
  ) {
    self.alignedCollectionViewFlowLayout = alignedCollectionViewFlowLayout
    self.borderColor = borderColor
    self.emptyLabel = emptyLabel
    self.emptyTextAlignment = emptyTextAlignment
  }
}

// MARK: - BookmarkListRouting

public protocol BookmarkListRouting: ViewableRouting {
  
}

// MARK: - BookmarkListListener

public protocol BookmarkListListener: AnyObject {
  func didTapTagCell(_ bookmark: Bookmark)
}

