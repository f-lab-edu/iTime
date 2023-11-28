//
//  BookmarkRepository.swift
//
//
//  Created by 이상헌 on 11/19/23.
//

import RxSwift

// MARK: - BookmarkRepository

public protocol BookmarkRepository {
  func update(with bookmarks: [Activity]) -> Single<[Activity]>
  func append(_ bookmark: Activity) -> Single<[Activity]>
  func remove(_ bookmark: Activity) -> Single<[Activity]>
  func bookmarks() -> Single<[Activity]>
}
