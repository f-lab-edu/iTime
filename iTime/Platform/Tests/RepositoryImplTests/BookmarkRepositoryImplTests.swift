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
  private var configuration: DummyDataConfiguration!
  
  private var disposeBag: DisposeBag!
  private var scheduler: TestScheduler!
  
  private var resultSubject: PublishSubject<[Activity]>!
  private lazy var observer = scheduler.record(
    resultSubject,
    disposeBag: disposeBag
  )
  
  // MARK: - Tests
  
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
    resultSubject = PublishSubject<[Activity]>()
    _ = observer
    
    sut = BookmarkRepositoryImpl(
      firestoreRepository: firestoreRepository,
      userDefaultRepository: userDefaultRepository
    )
  }
  
  func test_update() {
    // Given
    let dummyBookmarksFour = DummyData.DummyBookmark.dummyBookmarksFour
    
    // When
    scheduler.scheduleAt(1) {
      _ = self.sut.update(with: dummyBookmarksFour)
        .subscribe(onSuccess: { self.resultSubject.onNext($0) } )
    }
    
    // Then
    scheduler.start()
      
    XCTAssertEqual(observer.events, [
      .next(1, dummyBookmarksFour),
      ])
    XCTAssertEqual(firestoreRepository.updateCallCount, 1)
  }

  func test_append() {
    // Given
    let dummyBookmark = DummyData.DummyBookmark.dummyBookmarkOne
    
    // When
    scheduler.scheduleAt(1) {
      _ = self.sut.append(dummyBookmark)
        .subscribe(onSuccess: { self.resultSubject.onNext($0) })
    }
    
    // Then
    scheduler.start()
    
    XCTAssertEqual(observer.events, [
      .next(1, [dummyBookmark])
    ])
    //XCTAssertEqual(firestoreRepository.updateCallCount, 2)
  }
  
  func test_remove() {
    // Given
    let dummyBookmarkOne = DummyData.DummyBookmark.dummyBookmarkOne
    let dummyBookmarkTwo = DummyData.DummyBookmark.dummyBookmarkTwo
    let dummyBookmarks = [dummyBookmarkOne, dummyBookmarkTwo]
    
    // When
    scheduler.scheduleAt(1) {
      _ = self.sut.update(with: dummyBookmarks).subscribe()
    }
    
    scheduler.scheduleAt(2) {
      _ = self.sut.remove(dummyBookmarkTwo)
        .subscribe(onSuccess: { self.resultSubject.onNext($0) })
    }
      
    // Then
    scheduler.start()
      
    XCTAssertEqual(observer.events, [
      .next(2, [dummyBookmarkOne]),
      ])
    XCTAssertEqual(firestoreRepository.updateCallCount, 2)
  }
  
  func test_Bookmarks() {
    // Given
    let dummyBookmarks = DummyData.DummyBookmark.dummyBookmarksFour
    
    // When
    scheduler.scheduleAt(1) {
      _ = self.sut.update(with: dummyBookmarks).subscribe()
    }
    
    scheduler.scheduleAt(2) {
      _ = self.sut.bookmarks()
        .subscribe(onSuccess: { self.resultSubject.onNext($0) })
    }
    
    // Then
    scheduler.start()
    
    XCTAssertEqual(observer.events, [
      .next(2, dummyBookmarks),
      ])
    XCTAssertEqual(firestoreRepository.documentObservableCallCount, 2)
  }
  
}
