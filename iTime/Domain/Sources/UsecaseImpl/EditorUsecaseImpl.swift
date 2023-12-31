//
//  File.swift
//  
//
//  Created by 이상헌 on 12/27/23.
//

import RxSwift

import Entities
import Usecase
import Repository

public final class EditorUsecaseImpl: EditorUsecase {
  
  // MARK: Properties
  
  private let bookmarkModelDataStream: BookmarkModelDataStream
  private let timeLogRecordModelDataStream: TimeLogRecordModelDataStream
  
  private let bookmarkRepository: BookmarkRepository
  private let timeLogRecordRepository: TimeLogRecordRepository
  
  // MARK: - Initialization
  
  public init(
    bookmarkModelDataStream: BookmarkModelDataStream,
    timeLogRecordModelDataStream: TimeLogRecordModelDataStream,
    bookmarkRepository: BookmarkRepository,
    timeLogRecordRepository: TimeLogRecordRepository
  ) {
    self.bookmarkModelDataStream = bookmarkModelDataStream
    self.timeLogRecordModelDataStream = timeLogRecordModelDataStream
    self.bookmarkRepository = bookmarkRepository
    self.timeLogRecordRepository = timeLogRecordRepository
  }
  
  public func uploadBookmarks() -> Single<Void> {
    bookmarkModelDataStream.bookmarks
      .take(1)
      .asSingle()
      .flatMap(bookmarkRepository.update(with:))
      .map { _ in Void() }
  }
  
  public func uploadTimeLogRecord() -> Single<Void> {
    timeLogRecordModelDataStream.timeLogRecords
      .take(1)
      .asSingle()
      .flatMap(timeLogRecordRepository.update(with:))
      .map { _ in Void() }
  }
}
