//
//  File.swift
//  
//
//  Created by 이상헌 on 12/12/23.
//

import CoreLocation

import RxSwift
import RxRelay

import Repository

public final class LocationTrackerMock: LocationTracker {
  
  var dummyLocation = BehaviorRelay<CLLocationCoordinate2D>(value: .init())
  
  public var startLocationTrackingCallCount: Int = 0
  public func startLocationTracking() {
    startLocationTrackingCallCount += 1
  }
  
  public var stopLocationTrackingCallCount: Int = 0
  public func stopLocationTracking() {
    stopLocationTrackingCallCount += 1
  }
  
  public var resetLocationTrackingCallCount: Int = 0
  public func resetLocationTracking() {
    resetLocationTrackingCallCount += 1
  }
  
  public var currentUserLocationCallCount: Int = 0
  public func currentUserLocation() -> RxSwift.Observable<CLLocationCoordinate2D> {
    currentUserLocationCallCount += 1
    return .just(.init())
  }
  
  public init() {}
}
