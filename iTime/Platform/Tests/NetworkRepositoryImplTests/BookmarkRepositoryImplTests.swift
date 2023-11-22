import XCTest

import RxSwift

import RepositoryTestSupports
import NetworkRepository
@testable import NetworkRepositoryImpl

final class BookmarkRepositoryImplTests: XCTestCase {
  
  // MARK: - Properties
  
  private var sut: BookmarkRepository!
  private var firestoreRepository: FirestoreRepositoryMock!
  
  private var disposeBag: DisposeBag!
  
  // MARK: - Tests
  
  override func setUp() {
    super.setUp()
    
    firestoreRepository = FirestoreRepositoryMock()
    disposeBag = DisposeBag()
    
    sut = BookmarkRepositoryImpl(firestoreRepository: firestoreRepository)
  }
  
  func test_updateBookMark() {
    // Given
    let dummyBookmarks = DummyData.DummyBookmark.dummyBookmarks
    let userID = DummyData.DummyID.userID
    let expectation = XCTestExpectation()
    
    // When & Then
    sut.updateBookmarks(with: dummyBookmarks, for: userID)
      .subscribe { [weak self] result in
        switch result {
        case let .success(success):
          XCTAssertNoThrow(success)
          XCTAssertEqual(self?.firestoreRepository.updateCallCount, 1)
        case let .failure(error):
          XCTAssertNotNil(error)
        }
        expectation.fulfill()
      }
      .disposed(by: disposeBag)
    
    wait(for: [expectation], timeout: 1.5)
  }
  
  func test_appendBookmark() {
    // Given
    let dummyBookmark = DummyData.DummyBookmark.dummyBookmark
    let userID = DummyData.DummyID.userID
    let expectation = XCTestExpectation()
    
    // When & Then
    sut.appendBookmark(dummyBookmark, for: userID)
      .subscribe { [weak self] result in
        switch result {
        case let .success(success):
          XCTAssertNoThrow(success)
          XCTAssertEqual(self?.firestoreRepository.documentObservableCallCount, 1)
          XCTAssertEqual(self?.firestoreRepository.updateCallCount, 1)
        case let .failure(error):
          XCTAssertNotNil(error)
        }
        
        expectation.fulfill()
      }
      .disposed(by: disposeBag)
    
    wait(for: [expectation], timeout: 1.5)
  }
  
  func test_removeBookmark() {
    // Given
    let dummyBookmark = DummyData.DummyBookmark.dummyBookmark
    let userID = DummyData.DummyID.userID
    let expectation = XCTestExpectation()
    
    // When & Then
    sut.removeBookmark(dummyBookmark, for: userID)
      .subscribe { [weak self] result in
        switch result {
        case let .success(success):
          XCTAssertNoThrow(success)
          XCTAssertEqual(self?.firestoreRepository.updateCallCount, 1)
          XCTAssertEqual(self?.firestoreRepository.documentObservableCallCount, 1)
        case let .failure(error):
          XCTAssertNotNil(error)
        }
        expectation.fulfill()
      }
      .disposed(by: disposeBag)
    
    wait(for: [expectation], timeout: 1.5)
  }
  
  func test_Bookmarks() {
    // Given
    let userID = DummyData.DummyID.userID
    let expectation = XCTestExpectation()
    
    // When & Then
    sut.bookmarks(for: userID)
      .subscribe { [weak self] result in
        switch result {
        case let .success(success):
          XCTAssertNoThrow(success)
          XCTAssertEqual(self?.firestoreRepository.documentObservableCallCount, 1)
        case let .failure(error):
          XCTAssertNotNil(error)
        }
        expectation.fulfill()
      }
      .disposed(by: disposeBag)
    
    wait(for: [expectation], timeout: 1.5)
  }
  
}
