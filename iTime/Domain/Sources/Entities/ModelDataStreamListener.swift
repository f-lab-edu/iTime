//
//  File.swift
//  
//
//  Created by 이상헌 on 12/3/23.
//

// MARK: - ModelDataStreamListener

public protocol ModelDataStreamListener: AnyObject {
  func loadDataIfNeeded()
}
