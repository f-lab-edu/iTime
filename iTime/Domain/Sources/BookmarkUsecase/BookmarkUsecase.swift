//
//  File.swift
//  
//
//  Created by 이상헌 on 11/19/23.
//

import RxSwift

// MARK: - BookmarkUsecase

public protocol BookmarkUsecase {
  associatedtype Item
  func update(by bookmarks: [Item]) -> Single<Void>
  func append(by bookmark: Item) -> Single<Void>
  func remove(by bookmark: Item) -> Single<Void>
  func bookmarks() -> Single<[Item]>
}
