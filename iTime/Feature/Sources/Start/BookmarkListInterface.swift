//
//  BookmarkListInterface.swift
//  
//
//  Created by 이상헌 on 12/10/23.
//
import Foundation

import RIBs

import AppFoundation
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
  
  public init(alignedCollectionViewFlowLayout: AlignedCollectionViewFlowLayout, borderColor: ColorWrapper) {
    self.alignedCollectionViewFlowLayout = alignedCollectionViewFlowLayout
    self.borderColor = borderColor
  }
}

// MARK: - BookmarkListRouting

public protocol BookmarkListRouting: ViewableRouting {
  
}

// MARK: - BookmarkListListener

public protocol BookmarkListListener: AnyObject {
  func didTapTagCell(at index: IndexPath)
}

