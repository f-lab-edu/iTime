//
//  File.swift
//  
//
//  Created by 이상헌 on 12/12/23.
//

import CoreLocation

import RxSwift

import Repository
import AppFoundation

// MARK: - LocationTracker

public final class LocationTrackerImpl:
  NSObject,
  CLLocationManagerDelegate,
  LocationTracker,
  LocationFetcherDelegate
{
  
  private var locationFetcher: LocationFetcher

  private var currentCoorindates: [CLLocationCoordinate2D] = []
  private let userLocationSubject: BehaviorSubject<[CLLocationCoordinate2D]> = .init(value: [])
  private let applicationShared: ApplicationShared
  
  public init(
    applicationShared: ApplicationShared,
    locationFetcher: LocationFetcher
  ) {
    self.applicationShared = applicationShared
    self.locationFetcher = locationFetcher
  }
  
  public func currentUserLocation() -> Observable<CLLocationCoordinate2D> {
    return userLocationSubject
      .compactMap(\.last) // FIXME: 위치 빈도 수 가장 높은 지역의 Coordinate 추출 필요
      .asObservable()
  }
  
  public func stopLocationTracking() {
    locationFetcher.stopUpdatingLocation()
  }
  
  public func resetLocationTracking() {
    locationFetcher.stopUpdatingLocation()
    currentCoorindates = []
    userLocationSubject.onNext([])
  }
  
  public func startLocationTracking() {
    DispatchQueue.main.async { [weak self] in
      self?.locationFetcher.requestAlwaysAuthorization()
      self?.locationFetcher.requestWhenInUseAuthorization()
    }
    
    DispatchQueue.global().async { [weak self] in
      guard CLLocationManager.locationServicesEnabled() else {
        self?.requestLocationSettingPermission()
        return
      }
    }
    locationFetcher.locationFetcherDelegate = self
    locationFetcher.desiredAccuracy = kCLLocationAccuracyBest
    locationFetcher.allowsBackgroundLocationUpdates = true
    locationFetcher.startUpdatingLocation()
  }
  
  private func requestLocationSettingPermission() {
    guard let url = URL(string: "App-Prefs:root=Privacy&path=LOCATION") else { return }
    applicationShared.open(url, options: [:], completionHandler: nil)
  }
  
  public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    locationFetcher(manager, didUpdateLocations: locations)
  }
  
  public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    locationFetcher(manager, didFailWithError: error)
  }
  
  public func locationFetcher(_ fetcher: LocationFetcher, didUpdateLocations locations: [CLLocation]) {
    guard let currentLocation: CLLocationCoordinate2D = locations.last?.coordinate else { return }
    currentCoorindates.append(currentLocation)
    userLocationSubject.onNext(currentCoorindates)
  }
  
  public func locationFetcher(_ fetcher: LocationFetcher, didFailWithError error: Error) {
    userLocationSubject.onError(error)
  }
}
