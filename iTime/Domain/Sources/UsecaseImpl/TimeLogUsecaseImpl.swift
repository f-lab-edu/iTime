//
//  File.swift
//  
//
//  Created by 이상헌 on 11/30/23.
//

import RxSwift

import Repository
import Usecase
import Entities

// MARK: - TimeLogUsecaseImpl

public final class TimeLogUsecaseImpl: 
  TimeLogUsecase,
  ModelDataStreamListener
{

  // MARK: - Properties
  
  private let bookmarkRepository: BookmarkRepository
  private let timeLogRecordRepository: TimeLogRecordRepository
  private let bookmarkModelDataStream: BookmarkModelDataStream
  private let timeLogRecordModelDataStream: TimeLogRecordModelDataStream
  
  private var isLoaded: Bool = false

  // MARK: - Initialization

  public init(
    bookmarkRepository: BookmarkRepository,
    timeLogRecordRepository: TimeLogRecordRepository,
    bookmarkModelDataStream: BookmarkModelDataStream,
    timeLogRecordModelDataStream: TimeLogRecordModelDataStream
  ) {
    self.bookmarkRepository = bookmarkRepository
    self.timeLogRecordRepository = timeLogRecordRepository
    self.bookmarkModelDataStream = bookmarkModelDataStream
    self.timeLogRecordModelDataStream = timeLogRecordModelDataStream
  }
  
  // MARK: - Internal Methods
  
  public func preLoadAllData() -> Single<Void> {
    Single.zip(
      [loadTimeLogRecords(),
        loadBookmarks(),
      ]
    )
    .map( { _ in () })
    .do(onSuccess: { [weak self] in self?.isLoaded = true })
  }
  
  public func loadDataIfNeeded() {
    guard !isLoaded else { return }
    _ = preLoadAllData()
        .subscribe()
  }
  
  // MARK: - Private
  
  private func loadBookmarks() -> Single<Void> {
    bookmarkRepository.bookmarks()
      .flatMap { [weak self] bookmarks in
        self?.bookmarkModelDataStream.update(with: bookmarks)
        return .just(Void())
      }
  }
  
  private func loadTimeLogRecords() -> Single<Void> {
    timeLogRecordRepository.timeLogRecords()
      .flatMap { [weak self] records in
        self?.timeLogRecordModelDataStream.updateRecords(with: records)
        return .just(Void())
      }
  }
  
  private func updateLoadedData(by bookmarks: [Bookmark]) -> Observable<Void> {
    let updateBookmarkStream = bookmarkModelDataStream.bookmarks
      .withUnretained(self)
      .flatMap { owner, bookmarks in owner.bookmarkRepository.update(with: bookmarks) }
      .map { _ in () }
    
    let updateTimeLogRecordStream = timeLogRecordModelDataStream.timeLogRecords
      .withUnretained(self)
      .flatMap { owner, records in owner.timeLogRecordRepository.update(with: records) }
      .map { _ in () }
    
    return .merge(
      updateBookmarkStream,
      updateTimeLogRecordStream
    )
  }
  
}
