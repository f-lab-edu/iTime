//
//  File.swift
//  
//
//  Created by 이상헌 on 12/17/23.
//

import Foundation

public enum UnwrapError: Error {
  case nilValue
}

public protocol Unwrappable {
  associatedtype Wrapped
  func unwrap(errorIfNil: Error?) throws -> Wrapped
}

extension Optional: Unwrappable {
  public func unwrap(errorIfNil error: Error? = nil) throws -> Wrapped {
    switch self {
    case .some(let unwrapped):
      return unwrapped
    case .none:
      throw error ?? UnwrapError.nilValue
    }
  }
}

extension Result: Unwrappable {
  public func unwrap(errorIfNil: Error? = nil) throws -> Success {
    switch self {
    case .success(let value):
      return value
    case .failure(let error):
      throw errorIfNil ?? error
    }
  }
}

extension Result {
  
  public func mapThrow<NewSuccess>(_ transform: (Success) throws -> NewSuccess) -> Result<NewSuccess, Error> {
    do {
      return .success(try transform(try get()))
    } catch {
      return .failure(error)
    }
  }
  
  @discardableResult
  public func success(_ successHandler: (Success) -> Void) -> Result<Success, Failure> {
    if case .success(let value) = self {
      successHandler(value)
    }
    return self
  }
  
  @discardableResult
  public func `catch`(_ failureHandler: (Failure) -> Void) -> Result<Success, Failure> {
    if case .failure(let error) = self {
      failureHandler(error)
    }
    return self
  }
}
