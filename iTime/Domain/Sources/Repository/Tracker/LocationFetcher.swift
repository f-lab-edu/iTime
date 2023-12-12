//
//  File.swift
//  
//
//  Created by 이상헌 on 12/12/23.
//

import CoreLocation

// MARK: - LocationFetcherDelegate

public protocol LocationFetcherDelegate: AnyObject {
  func locationFetcher(_ fetcher: LocationFetcher, didUpdateLocations locations: [CLLocation])
  func locationFetcher(_ fetcher: LocationFetcher, didFailWithError error: Error)
}

// MARK: - LocationFetcher

public protocol LocationFetcher {
  var locationFetcherDelegate: LocationFetcherDelegate? { get set }
  
  var desiredAccuracy: CLLocationAccuracy { get set }
  var activityType: CLActivityType { get set }
  var allowsBackgroundLocationUpdates: Bool { get set }
  
  func startUpdatingLocation()
  func stopUpdatingLocation()
  func requestWhenInUseAuthorization()
  func requestAlwaysAuthorization()
  func islocationServicesEnabled() -> Bool
}
