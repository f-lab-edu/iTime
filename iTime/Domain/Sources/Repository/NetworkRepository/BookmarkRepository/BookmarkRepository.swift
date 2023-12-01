//
//  BookmarkRepository.swift
//
//
//  Created by 이상헌 on 11/19/23.
//

import RxSwift

import Entities

// MARK: - BookmarkRepository

public protocol BookmarkRepository {
  func update(with bookmarks: [Bookmark]) -> Single<[Bookmark]>
  func append(_ bookmark: Bookmark) -> Single<[Bookmark]>
  func remove(_ bookmark: Bookmark) -> Single<[Bookmark]>
  func bookmarks() -> Single<[Bookmark]>
}
