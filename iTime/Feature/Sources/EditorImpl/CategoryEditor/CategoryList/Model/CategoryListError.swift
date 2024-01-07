//
//  File.swift
//  
//
//  Created by 이상헌 on 1/5/24.
//

import Foundation

enum CategoryListError: Error, Equatable {
  case unknownError(String)
  case colorTransformError
  case noError
}
