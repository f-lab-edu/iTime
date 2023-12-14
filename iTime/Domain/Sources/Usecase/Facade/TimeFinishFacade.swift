//
//  File.swift
//  
//
//  Created by 이상헌 on 12/15/23.
//

import RxSwift

import Entities

public protocol TimeFinishFacade {
  func finish(_ record: TimeLogRecord) -> Observable<Void>
}
