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
  private let mutableBookmarkModelDataStream: MutableBookmarkModelDataStream
  private let mutableTimeLogRecordModelDataStream: MutableTimeLogRecordModelDataStream
  
  private var isLoaded: Bool = false

  // MARK: - Initialization

  public init(
    bookmarkRepository: BookmarkRepository,
    timeLogRecordRepository: TimeLogRecordRepository,
    mutableBookmarkModelDataStream: MutableBookmarkModelDataStream,
    mutableTimeLogRecordModelDataStream: MutableTimeLogRecordModelDataStream
  ) {
    self.bookmarkRepository = bookmarkRepository
    self.timeLogRecordRepository = timeLogRecordRepository
    self.mutableBookmarkModelDataStream = mutableBookmarkModelDataStream
    self.mutableTimeLogRecordModelDataStream = mutableTimeLogRecordModelDataStream
  }
  
  // MARK: - Internal Methods
  
  public func preLoadAllData() -> Single<Void> {
    Observable.merge(
      [loadBookmarks(),
      loadTimeLogRecords()]
        .map { $0.asObservable() }
    )
    .toArray()
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
        self?.mutableBookmarkModelDataStream.update(with: bookmarks)
        return .just(Void())
      }
  }
  
  private func loadTimeLogRecords() -> Single<Void> {
    timeLogRecordRepository.timeLogRecords()
      .flatMap { [weak self] records in
        self?.mutableTimeLogRecordModelDataStream.updateRecords(with: records)
        return .just(Void())
      }
  }
  
  private func updateLoadedData(by bookmarks: [Bookmark]) -> Observable<Void> {
    let updateBookmarkStream = mutableBookmarkModelDataStream.bookmarks
      .withUnretained(self)
      .flatMap { owner, bookmarks in owner.bookmarkRepository.update(with: bookmarks) }
      .map { _ in () }
    
    let updateTimeLogRecordStream = mutableTimeLogRecordModelDataStream.timeLogRecords
      .withUnretained(self)
      .flatMap { owner, records in owner.timeLogRecordRepository.update(with: records) }
      .map { _ in () }
    
    return .merge(
      updateBookmarkStream,
      updateTimeLogRecordStream
    )
  }
  
}
