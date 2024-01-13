//
//  File.swift
//  
//
//  Created by 이상헌 on 1/6/24.
//

import Entities
import AppFoundation

public struct CategoryListState {
  var timeLogRecords: [TimeLogRecord] = []
  var error: CategoryListError = .noError
}
