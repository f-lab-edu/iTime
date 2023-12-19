//
//  File.swift
//  
//
//  Created by 이상헌 on 12/19/23.
//

import Foundation

import RxSwift
import RxRelay

import AppFoundation

public final class ActivityLogModelStream {
  
  // MARK: - Properties
  
  public var activityLogStream: Observable<ActivityLog> { activityLogModelRelay.asObservable() }
  private let activityLogModelRelay = BehaviorRelay<ActivityLog>(value: ActivityLog())
  private var activityLogModelRelayBuilder: PropertyBuilder<ActivityLog> { activityLogModelRelay.value.builder }
  
  // MARK: - Internal Methods
  
  public func updateActivityLog(with activity: ActivityLog) {
    activityLogModelRelay.accept(activity)
  }
  
  public func updateActivityTitle(with title: String) {
    activityLogModelRelay.accept(
      activityLogModelRelayBuilder
        .title(title)
    )
  }
  
  public func updateCategoryLog(with category: CategotyLog) {
    activityLogModelRelay.accept(
      activityLogModelRelayBuilder
        .category(category)
    )
  }
  
  public init() {}
}
