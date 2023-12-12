//
//  File.swift
//
//
//  Created by 이상헌 on 12/12/23.
//

import CoreLocation

import Repository

extension CLLocationManager: LocationFetcher {
  public var locationFetcherDelegate: LocationFetcherDelegate? {
    get {
      return delegate as? LocationFetcherDelegate? ?? nil
    }
    set {
      delegate = newValue as? CLLocationManagerDelegate? ?? nil
    }
  }
  
  public func islocationServicesEnabled() -> Bool {
    let authorizationStatus = CLLocationManager.authorizationStatus()
    if authorizationStatus != .authorizedWhenInUse && authorizationStatus != .authorizedAlways {
      //alert
      print("Location Services are disabled!!! Status: \(authorizationStatus.rawValue)")
      return false
    }
    
    return CLLocationManager.locationServicesEnabled()
  }
}
