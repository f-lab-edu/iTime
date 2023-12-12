//
//  File.swift
//
//
//  Created by 이상헌 on 12/12/23.
//

import CoreLocation

import Repository

public final class LocationFetcherMock: LocationFetcher {
  
  enum MyError: Error {
    case dummyError
  }
  
  public var allowsBackgroundLocationUpdates: Bool = true
  
  public var desiredAccuracy: CLLocationAccuracy = kCLLocationAccuracyBestForNavigation
  
  public var activityType: CLActivityType = .fitness
  public var isLocationEnable: Bool = true
  weak public var locationFetcherDelegate: LocationFetcherDelegate?
  
  public var handleRequestLocation: (() -> CLLocation)?
  
  public func startUpdatingLocation() {
    if islocationServicesEnabled() {
      guard let location = handleRequestLocation?() else { return }
      locationFetcherDelegate?.locationFetcher(self, didUpdateLocations: [location])
    } else {
      locationFetcherDelegate?.locationFetcher(self, didFailWithError: MyError.dummyError)
    }
  }
  
  public var stopUpdatingLocationCallCount: Int = 0
  public func stopUpdatingLocation() {
    stopUpdatingLocationCallCount += 1
  }
  
  public var requestWhenInUseAuthorizationCallCount: Int = 0
  public func requestWhenInUseAuthorization() {
    requestWhenInUseAuthorizationCallCount += 1
  }
  
  public var requestAlwaysAuthorizationCallCount: Int = 0
  public func requestAlwaysAuthorization() {
    requestAlwaysAuthorizationCallCount += 1
  }
  
  public func islocationServicesEnabled() -> Bool {
    return isLocationEnable
  }
  
  public init() {}
}
