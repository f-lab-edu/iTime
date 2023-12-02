//
//  File.swift
//  
//
//  Created by 이상헌 on 11/30/23.
//

import RxSwift

// MARK: - TimeLogUsecase

public protocol TimeLogUsecase {
  func loadData() -> Single<Void>
}


