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
import NetworkRepository
import ProxyTestSupport
@testable import NetworkRepositoryImpl

final class TimeLogHistoryRepositoryImplTests: XCTestCase {
  
  // MARK: - Properties
  
  private var sut: TimeLogHistoryRepository!
  private var firestoreRepository: FirestoreRepositoryMock!
  private var userDefaultRepository: UserDefaultRepositoryMock!
  private var configuration: DummyDataConfiguration!
  
  private var disposeBag: DisposeBag!
  private var scheduler: TestScheduler!
  
  private var resultSubject: PublishSubject<[TimeLogHistory]>!
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
    resultSubject = PublishSubject<[TimeLogHistory]>()
    _ = observer
    
    sut = TimeLogHistoryRepositoryImpl(
      firestoreRepository: firestoreRepository,
      userDefaultRepository: userDefaultRepository
    )
  }
  
  func test_append() {
    // Given
    let dummyTimeLogHistory = DummyData.DummyTimeLogHistory.dummyTimeLogHistory
    
    // When
    scheduler.scheduleAt(1) {
      _ = self.sut.append(dummyTimeLogHistory)
        .subscribe(onSuccess: { self.resultSubject.onNext($0) } )
    }
    
    // Then
    scheduler.start()
      
    XCTAssertEqual(observer.events, [
      .next(1, [dummyTimeLogHistory]),
      ])
    XCTAssertEqual(firestoreRepository.updateCallCount, 1)
  }
  
  func test_remove() {
    
    // Given
    let dummyTimeLogHistoryID = DummyData.DummyID.timeLogHistoryID
    let dummyTimeLogHistory = DummyData.DummyTimeLogHistory.dummyTimeLogHistory
    
    // When
    scheduler.scheduleAt(1) {
      _ = self.sut.append(dummyTimeLogHistory).subscribe()
    }
    scheduler.scheduleAt(2) {
      _ = self.sut.remove(with: dummyTimeLogHistoryID)
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
    let dummyTimeLogHistory = DummyData.DummyTimeLogHistory.dummyTimeLogHistory
    
    // When
    scheduler.scheduleAt(1) {
      _ = self.sut.append(dummyTimeLogHistory).subscribe()
      _ = self.sut.append(dummyTimeLogHistory).subscribe()
      _ = self.sut.append(dummyTimeLogHistory).subscribe()
    }
    
    scheduler.scheduleAt(2) {
      _ = self.sut.timeLogHistories()
        .subscribe(onSuccess: { self.resultSubject.onNext($0) })
    }
    
    // Then
    scheduler.start()
    
    XCTAssertEqual(observer.events, [
      .next(2, [dummyTimeLogHistory,dummyTimeLogHistory,dummyTimeLogHistory]),
      ])
  }

}
