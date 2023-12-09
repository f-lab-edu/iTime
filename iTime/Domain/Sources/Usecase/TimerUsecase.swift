//
//  File.swift
//  
//
//  Created by 이상헌 on 12/8/23.
//

import RxSwift
import Entities
import Foundation

// MARK: - TimerUsecase

public protocol TimerUsecase {
  func start() -> Observable<Void>
  func stop()
  func save(_ activity: Activity) -> Observable<Void>
}
