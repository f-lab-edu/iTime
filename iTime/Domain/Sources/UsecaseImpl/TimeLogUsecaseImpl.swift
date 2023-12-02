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
  
  private var isLoaded: Bool = false
    
  // MARK: - Initialization

  public init(
    bookmarkRepository: BookmarkRepository,
    timeLogRecordRepository: TimeLogRecordRepository,
    mutableBookmarkModelDataStream: MutableBookmarkModelDataStream
  ) {
    self.bookmarkRepository = bookmarkRepository
    self.timeLogRecordRepository = timeLogRecordRepository
    self.mutableBookmarkModelDataStream = mutableBookmarkModelDataStream
  }
  
  // TimeLogRecord Data 같이 당기는 거 합치기 구현 전 입니다.
  public func preLoadAllData() -> Single<Void> {
    loadBookmarks()
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
  
  private func loadTimeLogs() -> Single<Void> {
    return .never()
  }
  
  private func updateLoadedData(by bookmarks: [Bookmark]) -> Observable<Void> {
    return .empty()
  }
  
}
