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

// MARK: - LocationTracker

public final class LocationTrackerImpl:
  NSObject,
  CLLocationManagerDelegate,
  LocationTracker
{
  
  private let locationManager = CLLocationManager()
  private var currentCoorindates: [CLLocationCoordinate2D] = []
  private let userLocationRelay: BehaviorRelay<[CLLocationCoordinate2D]> = .init(value: [])
  private let applicationShared: ApplicationShared
  
  init(applicationShared: ApplicationShared) {
    self.applicationShared = applicationShared
  }
  
  public func currentUserLocation() -> Observable<CLLocationCoordinate2D> {
    return userLocationRelay
      .compactMap(\.last) // FIXME: 위치 빈도 수 가장 높은 지역의 Coordinate 추출 필요
      .asObservable()
  }
  
  public func stopLocationTracking() {
    locationManager.stopUpdatingLocation()
  }
  
  public func resetLocationTracking() {
    locationManager.stopUpdatingLocation()
    currentCoorindates = []
    userLocationRelay.accept([])
  }
  
  public func startLocationTracking() {
    locationManager.requestAlwaysAuthorization()
    locationManager.requestWhenInUseAuthorization()
    
    guard CLLocationManager.locationServicesEnabled() else {
      requestLocationSettingPermission()
      return
    }
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.allowsBackgroundLocationUpdates = true
    locationManager.startUpdatingLocation()
  }
  
  public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let currentLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    currentCoorindates.append(currentLocation)
    userLocationRelay.accept(currentCoorindates)
  }
  
  private func requestLocationSettingPermission() {
    guard let url = URL(string: "App-Prefs:root=Privacy&path=LOCATION") else { return }
    applicationShared.open(url: url)
  }
}
