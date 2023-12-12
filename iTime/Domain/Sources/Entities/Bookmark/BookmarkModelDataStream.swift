//
//  File.swift
//
//
//  Created by 이상헌 on 11/30/23.
//


import RxRelay
import RxSwift

// MARK: - BookmarkData

struct BookmarkModelData: Equatable {
  let models: [Bookmark]
  let modelByTitle: [String: Bookmark]
  
  init(
    models: [Bookmark] = [],
    modelByTitle: [String : Bookmark] = [:]
  ) {
    self.models = models
    self.modelByTitle = modelByTitle
  }
}

// MARK: - BookmarkDataStreamImpl

public final class BookmarkModelDataStream {
  
  // MARK: - Properties
  
  public var bookmarks: Observable<[Bookmark]> {
    bookmarkModelDataRelay
      .asObservable()
      .do(onSubscribe: { [weak self] in self?.listener?.loadDataIfNeeded() } )
      .map(\.models)
  }
  private let bookmarkModelDataRelay = BehaviorRelay<BookmarkModelData>(value: BookmarkModelData())

  public weak var listener: ModelDataStreamListener?
  
  // MARK: - Internal Methods
  
  public func update(with bookmarks: [Bookmark]) {
    let bookmarkModelByTitle = bookmarks.reduce(into: [String: Bookmark]()) { $0[$1.title] = $1 }
    let data = BookmarkModelData(models: bookmarks, modelByTitle: bookmarkModelByTitle)
    bookmarkModelDataRelay.accept(data)
  }
  
  public func append(_ bookmark: Bookmark) {
    var newBookmarks: [Bookmark] {
      var models = bookmarkModelDataRelay.value.models
      models.append(bookmark)
      return models
    }
    
    var newBookmarkModelByTitle: [String: Bookmark] {
      var modelByTitle = bookmarkModelDataRelay.value.modelByTitle
      modelByTitle[bookmark.title] = bookmark
      return modelByTitle
    }
    let data = BookmarkModelData(models: newBookmarks, modelByTitle: newBookmarkModelByTitle)
    bookmarkModelDataRelay.accept(data)
  }
  
  public func remove(_ bookmark: Bookmark) {
    var newBookmarks: [Bookmark] {
      let models = bookmarkModelDataRelay.value.models.filter { $0 != bookmark }
      return models
    }
    
    var newBookmarkModelByTitle: [String: Bookmark] {
      var modelByTitle = bookmarkModelDataRelay.value.modelByTitle
      modelByTitle.removeValue(forKey: bookmark.title)
      return modelByTitle
    }
    let data = BookmarkModelData(models: newBookmarks, modelByTitle: newBookmarkModelByTitle)
    bookmarkModelDataRelay.accept(data)
  }
  
  public init() {}
}
