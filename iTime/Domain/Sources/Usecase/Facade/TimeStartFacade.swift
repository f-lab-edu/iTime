//
//  File.swift
//  
//
//  Created by 이상헌 on 12/15/23.
//

import RxSwift

public protocol TimeStartFacade {
  func start() -> Observable<Void>
}
