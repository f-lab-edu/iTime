//
//  File.swift
//  
//
//  Created by 이상헌 on 12/9/23.
//

import Foundation

extension Int {
  var hour: Int {
    self / 3600
  }
  var minute: Int {
    (self % 3600) / 60
  }
  var seconds: Int {
    (self % 60)
  }
}
