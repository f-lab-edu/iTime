//
//  File.swift
//  
//
//  Created by 이상헌 on 11/19/23.
//

import RxSwift

// MARK: - BookmarkUsecase

public protocol BookmarkUsecase {
  func update(by bookmarks: [Bookmark]) -> Single<Void>
  func append(by bookmark: Bookmark) -> Single<Void>
  func remove(by bookmark: Bookmark) -> Single<Void>
  func bookmarks() -> Single<[Bookmark]>
}
