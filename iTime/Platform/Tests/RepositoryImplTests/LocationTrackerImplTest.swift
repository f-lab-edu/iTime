//
//  LocationTrackerImplTest.swift
//
//
//  Created by 이상헌 on 12/12/23.
//

import XCTest
import UIKit
import CoreLocation

import RepositoryTestSupports

@testable import RepositoryImpl

final class LocationTrackerImplTest: XCTestCase {
  
  private var sut: LocationTrackerImpl!
  private var locationFetcher: LocationFetcherMock!
  
  override func setUp() {
    
    locationFetcher = LocationFetcherMock()
    sut = LocationTrackerImpl(
      applicationShared: UIApplication.shared,
      locationFetcher: locationFetcher
    )
    locationFetcher.locationFetcherDelegate = sut
  }
  
  func test_When_Input_RandomLocation() async throws {
    // Given
    let expectedLocation = CLLocation(latitude: 21.99873, longitude: 99.39393)
    
    // When
    locationFetcher.handleRequestLocation = {
      return expectedLocation
    }
    sut.startLocationTracking()
    async let result = sut.currentUserLocation().take(1).values
  
    // Then
    let coordiate = try await result.first(where: { _ in true })
    XCTAssertEqual(coordiate?.latitude, expectedLocation.coordinate.latitude)
    XCTAssertEqual(coordiate?.longitude, expectedLocation.coordinate.longitude)
    XCTAssertNotEqual(locationFetcher.desiredAccuracy, 0)
    XCTAssertNotNil(locationFetcher.locationFetcherDelegate)
  }
  
  func test_When_Invoke_LocationError() async throws {
    // Given
    let expectedLocation = CLLocation(latitude: 21.99873, longitude: 99.39393)
    let errorLocationCoordinate = CLLocationCoordinate2D(latitude: -1, longitude: -1)
    locationFetcher.isLocationEnable = false
    
    // When
    locationFetcher.handleRequestLocation = {
      return expectedLocation
    }
    sut.startLocationTracking()
    async let result = sut.currentUserLocation().catchAndReturn(errorLocationCoordinate).values
    
    // Then
    let coordiate = try await result.first(where: { _ in true })
    XCTAssertEqual(coordiate?.latitude, errorLocationCoordinate.latitude)
    XCTAssertEqual(coordiate?.longitude, errorLocationCoordinate.longitude)
    XCTAssertNotEqual(locationFetcher.desiredAccuracy, 0)
    XCTAssertNotNil(locationFetcher.locationFetcherDelegate)
  }
  
}
