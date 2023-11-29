//
//  File.swift
//  
//
//  Created by 이상헌 on 11/19/23.
//

import RxSwift

import Entities

// MARK: - BookmarkUsecase

public protocol BookmarkUsecase {
  func update(with bookmarks: [Bookmark]) -> Single<Void>
  func append(_ bookmark: Bookmark) -> Single<Void>
  func remove(_ bookmark: Bookmark) -> Single<Void>
  func bookmarks() -> Single<[Bookmark]>
}
