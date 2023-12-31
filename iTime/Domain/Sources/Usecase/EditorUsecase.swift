//
//  File.swift
//  
//
//  Created by 이상헌 on 12/27/23.
//

import RxSwift

public protocol EditorUsecase {
  func uploadBookmarks() -> Single<Void>
  func uploadTimeLogRecord() -> Single<Void>
}
