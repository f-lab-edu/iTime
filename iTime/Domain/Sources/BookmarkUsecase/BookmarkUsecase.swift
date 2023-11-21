//
//  File.swift
//  
//
//  Created by 이상헌 on 11/19/23.
//

import RxSwift

// MARK: - BookmarkUsecase

public protocol BookmarkUsecase {
  func update(with bookmarks: [Bookmark]) -> Single<Void>
  func append(with bookmark: Bookmark) -> Single<Void>
  func remove(with bookmark: Bookmark) -> Single<Void>
  func bookmarks() -> Single<[Bookmark]>
}
