import XCTest

import RxSwift
import RxBlocking

import RepositoryTestSupports
import NetworkRepository
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
    
    firestoreRepository = FirestoreRepositoryMock()
    userDefaultRepository = UserDefaultRepositoryMock()
    disposeBag = DisposeBag()
    
    sut = BookmarkRepositoryImpl(
      firestoreRepository: firestoreRepository,
      userDefaultRepository: userDefaultRepository
    )
  }
  
  func test_updateBookmark() {
    // Given
    let dummyBookmarks = DummyData.DummyBookmark.dummyBookmarks
    
    // When & Then
    do {
      let result = try sut.updateBookmarks(with: dummyBookmarks)
        .toBlocking()
        .first()
        .map { true }
      XCTAssertEqual(result, true)
      XCTAssertEqual(firestoreRepository.updateCallCount, 1)
      XCTAssertEqual(userDefaultRepository.userIDCallCount, 1)
    } catch {
      XCTFail(error.localizedDescription)
    }
  }
  
  func test_appendBookmark() {
    // Given
    let dummyBookmark = DummyData.DummyBookmark.dummyBookmark
    
    // When & Then
    do {
      let result = try sut.appendBookmark(dummyBookmark)
        .toBlocking()
        .first()
        .map { true }
      XCTAssertEqual(result, true)
      XCTAssertEqual(firestoreRepository.updateCallCount, 1)
      XCTAssertEqual(firestoreRepository.documentObservableCallCount, 1)
      XCTAssertEqual(userDefaultRepository.userIDCallCount, 2)
  } catch {
    XCTFail(error.localizedDescription)
    }
  }
  
  func test_removeBookmark() {
    // Given
    let dummyBookmark = DummyData.DummyBookmark.dummyBookmark
    
    // When & Then
    do {
      let result = try sut.removeBookmark(dummyBookmark)
        .toBlocking()
        .first()
        .map { true }
      XCTAssertEqual(result, true)
      XCTAssertEqual(firestoreRepository.updateCallCount, 1)
      XCTAssertEqual(firestoreRepository.documentObservableCallCount, 1)
      XCTAssertEqual(userDefaultRepository.userIDCallCount, 2)
  } catch {
    XCTFail(error.localizedDescription)
    }
  }
  
  func test_Bookmarks() {
    // When & Then
    do {
      let result = try sut.bookmarks()
        .toBlocking()
        .first()
      
      XCTAssertEqual(result, DummyData.DummyBookmark.dummyBookmarks)
      XCTAssertEqual(firestoreRepository.documentObservableCallCount, 1)
      XCTAssertEqual(userDefaultRepository.userIDCallCount, 1)
  } catch {
    XCTFail(error.localizedDescription)
    }
  }
  
}
