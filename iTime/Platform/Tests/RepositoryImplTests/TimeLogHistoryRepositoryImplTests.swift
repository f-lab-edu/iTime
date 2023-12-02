//
//  TimeLogHistoryRepositoryImplTests.swift
//  
//
//  Created by 이상헌 on 11/26/23.
//

import XCTest

import RxSwift
import RxTest

import RepositoryTestSupports
import Repository
import Entities
import Translator
import ProxyTestSupport
@testable import RepositoryImpl

final class TimeLogHistoryRepositoryImplTests: XCTestCase {
  
  // MARK: - Properties
  
  private var sut: TimeLogRecordRepository!
  private var firestoreRepository: FirestoreRepositoryMock!
  private var userDefaultRepository: UserDefaultRepositoryMock!
  private var configuration: DummyDataConfiguration!
  
  private var disposeBag: DisposeBag!
  private var scheduler: TestScheduler!
  
  private var resultSubject: PublishSubject<[TimeLogRecord]>!
  private lazy var observer = scheduler.record(
    resultSubject,
    disposeBag: disposeBag
  )

  override func setUp() {
    super.setUp()
    
    configuration = DummyDataConfiguration()
    firestoreRepository = FirestoreRepositoryMock(
      documentSnapshotMock: DocumentSnapshotMock(configuration: configuration),
      querySnapShotMock: QuerySnapshotMock(configuration: configuration),
      configuration: configuration
    )
    userDefaultRepository = UserDefaultRepositoryMock()
    scheduler = TestScheduler(initialClock: 0)
    disposeBag = DisposeBag()
    resultSubject = PublishSubject<[TimeLogRecord]>()
    _ = observer
    
    sut = TimeLogRecordRepositoryImpl(
      firestoreRepository: firestoreRepository,
      userDefaultRepository: userDefaultRepository,
      translator: TimeLogRecordTranslator()
    )
  }
  
  func test_append() {
    // Given
    let dummyTimeLogRecord = DummyData.DummyTimeLogHistory.dummyTimeLogRecord
    
    // When
    scheduler.scheduleAt(1) {
      _ = self.sut.append(dummyTimeLogRecord)
        .subscribe(onSuccess: { self.resultSubject.onNext($0) } )
    }
    
    // Then
    scheduler.start()
      
    XCTAssertEqual(observer.events, [
      .next(1, [dummyTimeLogRecord]),
      ])
    XCTAssertEqual(firestoreRepository.updateCallCount, 1)
  }
  
  func test_remove() {
    
    // Given
    let dummyTimeLogRecordID = DummyData.DummyID.timeLogHistoryID
    let dummyTimeLogRecord = DummyData.DummyTimeLogHistory.dummyTimeLogRecord
    
    // When
    scheduler.scheduleAt(1) {
      _ = self.sut.append(dummyTimeLogRecord).subscribe()
    }
    scheduler.scheduleAt(2) {
      _ = self.sut.remove(with: dummyTimeLogRecordID)
        .subscribe(onSuccess: { self.resultSubject.onNext($0) })
    }
    
    // Then
    scheduler.start()
      
    XCTAssertEqual(observer.events, [
      .next(2, []),
      ])
    XCTAssertEqual(firestoreRepository.updateCallCount, 2)
  }
  
  func test_timeLogHistorires() {
    // Given
    let dummyTimeLogRecord = DummyData.DummyTimeLogHistory.dummyTimeLogRecord
    
    // When
    scheduler.scheduleAt(1) {
      _ = self.sut.append(dummyTimeLogRecord).subscribe()
      _ = self.sut.append(dummyTimeLogRecord).subscribe()
      _ = self.sut.append(dummyTimeLogRecord).subscribe()
    }
    
    scheduler.scheduleAt(2) {
      _ = self.sut.timeLogHistories()
        .subscribe(onSuccess: { self.resultSubject.onNext($0) })
    }
    
    // Then
    scheduler.start()
    
    XCTAssertEqual(observer.events, [
      .next(2, [dummyTimeLogRecord,dummyTimeLogRecord,dummyTimeLogRecord]),
      ])
  }

}
