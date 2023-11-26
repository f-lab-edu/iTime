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
  
  private var disposeBag: DisposeBag!

  override func setUp() {
    super.setUp()
    
    firestoreRepository = FirestoreRepositoryMock(
      documentSnapshotMock: TimeLogHistoryDocumentSnapshotMock(),
      querySnapShotMock: TimeLogHistorykQuerySnapshotMock()
    )
    userDefaultRepository = UserDefaultRepositoryMock()
    disposeBag = DisposeBag()
    
    sut = TimeLogHistoryRepositoryImpl(
      firestoreRepository: firestoreRepository,
      userDefaultRepository: userDefaultRepository
    )
  }
  
  func test_append() {
    // Given
    let scheduler = TestScheduler(initialClock: 0)
    let dummyTimeLogHistory = DummyData.DummyTimeLogHistory.dummyTimeLogHistory
    let resultSubject = PublishSubject<Bool>()
    
    // When
    scheduler.scheduleAt(10, action: { [weak self] in
      guard let self else { return }
      _ = self.sut.append(dummyTimeLogHistory)
        .subscribe { result in
          switch result {
          case .success:
            resultSubject.onNext(true)
          case .failure:
            resultSubject.onNext(false)
          }
        }
        .disposed(by: disposeBag)
    })
    
    let observer = scheduler.record(
      resultSubject,
      disposeBag: disposeBag
    )
    
    // Then
    scheduler.start()
    
    XCTAssertEqual(observer.events, [
      .next(10, true)
    ])
    XCTAssertEqual(firestoreRepository.documentObservableCallCount, 1)
    XCTAssertEqual(userDefaultRepository.userIDCallCount, 2)
    XCTAssertEqual(firestoreRepository.updateCallCount, 1)
  }
  
  func test_remove() {
    // Given
    let scheduler = TestScheduler(initialClock: 0)
    let dummyTimeLogHistoryID = DummyData.DummyID.timeLogHistoryID
    let resultSubject = PublishSubject<Bool>()
    
    // When
    scheduler.scheduleAt(10, action: { [weak self] in
      guard let self else { return }
      _ = self.sut.remove(with: dummyTimeLogHistoryID)
        .subscribe { result in
          switch result {
          case .success:
            resultSubject.onNext(true)
          case .failure:
            resultSubject.onNext(false)
          }
        }
        .disposed(by: disposeBag)
    })
    
    let observer = scheduler.record(
      resultSubject,
      disposeBag: disposeBag
    )
    
    // Then
    scheduler.start()
    
    XCTAssertEqual(observer.events, [
      .next(10, true)
    ])
    XCTAssertEqual(firestoreRepository.documentObservableCallCount, 1)
    XCTAssertEqual(userDefaultRepository.userIDCallCount, 2)
    XCTAssertEqual(firestoreRepository.updateCallCount, 1)
  }
  
  func test_timeLogHistorires() {
    // Given
    let scheduler = TestScheduler(initialClock: 0)
    let resultSubject = PublishSubject<[TimeLogHistory]>()
    
    // When
    scheduler.scheduleAt(10, action: { [weak self] in
      guard let self else { return }
      _ = self.sut.timeLogHistories()
        .subscribe { result in
          switch result {
          case let .success(histories):
            resultSubject.onNext(histories)
          case .failure:
            resultSubject.onNext([])
          }
        }
        .disposed(by: disposeBag)
    })
    
    let observer = scheduler.record(
      resultSubject,
      disposeBag: disposeBag
    )
    
    // Then
    scheduler.start()
    
    XCTAssertEqual(observer.events, [
      .next(10, DummyData.DummyTimeLogHistory.dummyTimeLogHisotries)
    ])
    XCTAssertEqual(firestoreRepository.documentObservableCallCount, 1)
    XCTAssertEqual(userDefaultRepository.userIDCallCount, 1)
  }

}
