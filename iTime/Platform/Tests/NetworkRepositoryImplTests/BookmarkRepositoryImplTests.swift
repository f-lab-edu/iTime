import XCTest

import RxSwift
import RxTest

import RepositoryTestSupports
import NetworkRepository
import ProxyTestSupport
@testable import NetworkRepositoryImpl

final class BookmarkRepositoryImplTests: XCTestCase {
  
  // MARK: - Properties
  
  private var sut: BookmarkRepository!
  private var firestoreRepository: FirestoreRepositoryMock!
  private var userDefaultRepository: UserDefaultRepositoryMock!
  
  private var disposeBag: DisposeBag!
  
  // MARK: - Tests
  
  override func setUp() {
    super.setUp()
    
    firestoreRepository = FirestoreRepositoryMock(
      documentSnapshotMock: BookmarkDocumentSnapshotMock(),
      querySnapShotMock: BookmarkQuerySnapshotMock()
    )
    userDefaultRepository = UserDefaultRepositoryMock()
    disposeBag = DisposeBag()
    
    sut = BookmarkRepositoryImpl(
      firestoreRepository: firestoreRepository,
      userDefaultRepository: userDefaultRepository
    )
  }
  
  func test_updateBookmark() {
    // Given
    let scheduler = TestScheduler(initialClock: 0)
    let dummyBookmarks = DummyData.DummyBookmark.dummyBookmarks
    let resultSubject = PublishSubject<Bool>()
    
    // When
    scheduler.scheduleAt(10) { [weak self] in
      guard let self else { return }
      _ = self.sut.updateBookmarks(with: dummyBookmarks)
        .subscribe { result in
          switch result {
          case .success:
            resultSubject.onNext(true)
          case .failure:
            resultSubject.onNext(false)
          }
        }
        .disposed(by: disposeBag)
    }
    
    let observer = scheduler.record(
      resultSubject,
      disposeBag: disposeBag
    )
    
    // Then
    scheduler.start()
      
    XCTAssertEqual(observer.events, [
      .next(10, true),
      ])
    XCTAssertEqual(firestoreRepository.updateCallCount, 1)
    XCTAssertEqual(userDefaultRepository.userIDCallCount, 1)
  }

  func test_appendBookmark() {
    // Given
    let scheduler = TestScheduler(initialClock: 0)
    let dummyBookmark = DummyData.DummyBookmark.dummyBookmark
    let resultSubject = PublishSubject<Bool>()
    
    // When
    scheduler.scheduleAt(10) { [weak self] in
      guard let self else { return }
      _ = self.sut.appendBookmark(dummyBookmark)
        .subscribe { result in
          switch result {
          case .success:
            resultSubject.onNext(true)
          case .failure:
            resultSubject.onNext(false)
          }
        }
        .disposed(by: disposeBag)
    }
    
    let observer = scheduler.record(
      resultSubject,
      disposeBag: disposeBag
    )
    
    // Then
    scheduler.start()
      
    XCTAssertEqual(observer.events, [
      .next(10, true),
      ])
    XCTAssertEqual(firestoreRepository.documentObservableCallCount, 1)
    XCTAssertEqual(userDefaultRepository.userIDCallCount, 2)
    XCTAssertEqual(firestoreRepository.updateCallCount, 1)
  }
  
  func test_removeBookmark() {
    // Given
    let scheduler = TestScheduler(initialClock: 0)
    let dummyBookmark = DummyData.DummyBookmark.dummyBookmark
    let resultSubject = PublishSubject<Bool>()
    
    // When
    scheduler.scheduleAt(10) { [weak self] in
      guard let self else { return }
      _ = self.sut.removeBookmark(dummyBookmark)
        .subscribe { result in
          switch result {
          case .success:
            resultSubject.onNext(true)
          case .failure:
            resultSubject.onNext(false)
          }
        }
        .disposed(by: disposeBag)
    }
    
    let observer = scheduler.record(
      resultSubject,
      disposeBag: disposeBag
    )
    
    // Then
    scheduler.start()
      
    XCTAssertEqual(observer.events, [
      .next(10, true),
      ])
    XCTAssertEqual(firestoreRepository.updateCallCount, 1)
    XCTAssertEqual(firestoreRepository.documentObservableCallCount, 1)
    XCTAssertEqual(userDefaultRepository.userIDCallCount, 2)
  }
  
  func test_Bookmarks() {
    // Given
    let scheduler = TestScheduler(initialClock: 0)
    let resultSubject = PublishSubject<[Activity]>()
    
    // When
    scheduler.scheduleAt(10) { [weak self] in
      guard let self else { return }
      _ = self.sut.bookmarks()
        .subscribe { result in
          switch result {
          case let .success(bookmarks):
            resultSubject.onNext(bookmarks)
          case .failure:
            resultSubject.onNext([])
          }
        }
        .disposed(by: disposeBag)
    }
    
    let observer = scheduler.record(
      resultSubject,
      disposeBag: disposeBag
    )
    
    // Then
    scheduler.start()
    
    XCTAssertEqual(observer.events, [
      .next(10, DummyData.DummyBookmark.dummyBookmarks),
      ])
    XCTAssertEqual(firestoreRepository.documentObservableCallCount, 1)
    XCTAssertEqual(userDefaultRepository.userIDCallCount, 1)
  }
  
}
