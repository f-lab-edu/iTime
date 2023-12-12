//
//  File.swift
//
//
//  Created by 이상헌 on 12/9/23.
//

import RxSwift
import RxRelay

import CoreLocation

// MARK: - ApplicationShared

public protocol ApplicationShared {
  func open(url: URL)
}

// MARK: - LocationTracker

public protocol LocationTracker {
  func startLocationTracking()
  func stopLocationTracking()
  func resetLocationTracking()
  
  func currentUserLocation() -> Observable<CLLocationCoordinate2D>
}
