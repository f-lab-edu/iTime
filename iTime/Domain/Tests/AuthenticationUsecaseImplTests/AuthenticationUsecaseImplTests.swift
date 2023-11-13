import XCTest
import RepositoryTestSupports
import AuthenticationRepository
@testable import AuthenticationUsecaseImpl

import RxSwift

final class AuthenticationUsecaseImplTests: XCTestCase {
    
    private var sut: AuthenticationUsecaseImpl!
    private var notificationCenter: NotificationCenterSpy!
    private var firebaseAppleAuthenticationRepository: AuthenticationRepositoryMock!
    
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        
        firebaseAppleAuthenticationRepository = AuthenticationRepositoryMock()
        notificationCenter = NotificationCenterSpy(delaySeconds: 1)
        disposeBag = DisposeBag()
      
        sut = AuthenticationUsecaseImpl(
            appleAuthenticationRepository: firebaseAppleAuthenticationRepository,
            notificationCenter: notificationCenter,
            authorizationContextProvider: ASAuthrizationContextProviderMock()
        )
    }
}

// MARK: - SignIn

extension AuthenticationUsecaseImplTests {
    func test_signIn_execution() throws {
        // When
        _ = sut.signIn()
            .subscribe()
            .dispose()
        
        // Then
        XCTAssertEqual(firebaseAppleAuthenticationRepository.signInCallCount, 1)
    }
    
    func test_signInSuccess_Notification_Response() throws {
        // Given
        let expectation = XCTestExpectation()
        
        // When & Then
        sut.signIn()
            .subscribe { success in
                XCTAssertNoThrow(success)
                
                expectation.fulfill()
            }
            .disposed(by: disposeBag)
        
        notificationCenter.post(
          name: AuthenticationSuccess.signIn.notificationName,
            object: nil
        )
       
        wait(for: [expectation], timeout: 1.5)
    }
    
    func test_signInError_Notificatioin_Response() throws {
        // Given
        let expectation = XCTestExpectation()
        
        // When & Then
        sut.signIn()
            .catch({ error in
                XCTAssertGreaterThan(error.localizedDescription.count, 0)
                
                expectation.fulfill()
                return .never()
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        notificationCenter.post(
            name: AuthenticationError.signInError.notificationName,
            object: nil
        )
       
        wait(for: [expectation], timeout: 1.5)
    }
}

// MARK: - SignOut

extension AuthenticationUsecaseImplTests {
    func test_signOut_execution() throws {
        // When
        _ = sut.signOut()
            .subscribe()
            .dispose()
        
        // Then
        XCTAssertEqual(firebaseAppleAuthenticationRepository.signOutCallCount, 1)
    }
    
    func test_signOutSuccess_Notification_Response() throws {
        // Given
        let expectation = XCTestExpectation()
        
        // When & Then
        sut.signOut()
            .subscribe { success in
                XCTAssertNoThrow(success)
                
                expectation.fulfill()
            }
            .disposed(by: disposeBag)
        
        notificationCenter.post(
            name: AuthenticationSuccess.signOut.notificationName,
            object: nil
        )
       
        wait(for: [expectation], timeout: 1.5)
    }

    func test_signOutError_Notification_Response() throws {
        // Given
        let expectation = XCTestExpectation()
        
        // When & Then
        sut.signOut()
            .catch({ error in
                XCTAssertGreaterThan(error.localizedDescription.count, 0)
                
                expectation.fulfill()
                return .never()
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        notificationCenter.post(
            name: AuthenticationError.signOutError.notificationName,
            object: nil
        )
       
        wait(for: [expectation], timeout: 1.5)
    }
}

// MARK: - DeleteUser

extension AuthenticationUsecaseImplTests {
    func test_deleteCurrentUser_execution() throws {
        // Given
        let authrizationContextProviderMock = ASAuthrizationContextProviderMock()
        
        // When
        _ = sut.deleteCurrentUser()
            .subscribe()
            .dispose()
        
        // Then
        XCTAssertEqual(firebaseAppleAuthenticationRepository.deleteCurrentUserCallCount, 1)
    }
    
    func test_deleteCurrentUserSuccess_Notification_Response() throws {
        // Given
        let expectation = XCTestExpectation()
        
        // When & Then
        sut.deleteCurrentUser()
            .subscribe { success in
                XCTAssertNoThrow(success)
                
                expectation.fulfill()
            }
            .disposed(by: disposeBag)
        
        notificationCenter.post(
            name: AuthenticationSuccess.deleteUser.notificationName,
            object: nil
        )
       
        wait(for: [expectation], timeout: 1.5)
    }
    
    func test_deleteCurrentUserError_Notification_Response() throws {
        // Given
        let expectation = XCTestExpectation()
        
        // When & Then
        sut.deleteCurrentUser()
            .catch({ error in
                XCTAssertGreaterThan(error.localizedDescription.count, 0)
                
                expectation.fulfill()
                return .never()
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        notificationCenter.post(
            name: AuthenticationError.deleteUserError.notificationName,
            object: nil
        )
       
        wait(for: [expectation], timeout: 1.5)
    }
}
