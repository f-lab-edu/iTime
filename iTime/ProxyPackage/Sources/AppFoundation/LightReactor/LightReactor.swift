//
//  File.swift
//
//
//  Created by 이상헌 on 12/5/23.
//
import Foundation

import RxSwift
import RIBs

// MARK: - Reactor

public protocol LightReactor: 
  AnyObject,
  AssociatedObjectStore
{
  associatedtype Action
  associatedtype Mutation = Action
  associatedtype State
  
  var action: PublishSubject<Action> { get }
  
  var initalState: State { get }
  
  var state: Observable<State> { get }
    
  var currentState: State { get }
  
  func sendAction(_ action: Action)
  
  func mutate(action: Action) -> Observable<Mutation>
  
  func transform(mutation: Observable<Mutation>) -> Observable<Mutation>
  
  func reduce(state: State, mutation: Mutation) -> State
}

// warning 제거 참고
// https://github.com/atrick/swift-evolution/blob/diagnose-implicit-raw-bitwise/proposals/nnnn-implicit-raw-bitwise-conversion.md#workarounds-for-common-cases

// pointer
private struct AssociatedKey {
  static var actionKey: Void?
  static var currentStateKey: Void?
}

// MARK: - Reactor Impl

extension LightReactor where Self: Interactor {
  
  var _action: PublishSubject<Action> {
    return associatedObject(forKey: &AssociatedKey.actionKey, default: .init())
  }
  
  public var action: PublishSubject<Action> {
    _ = self.state
    return _action
  }
  
  public var state: Observable<State> {
    return self.makeStreamCycle()
  }
  
  public func sendAction(_ action: Action) {
    self.action.on(.next(action))
  }
  
  public internal(set) var currentState: State {
    get { return self.associatedObject(forKey: &AssociatedKey.currentStateKey, default: self.initalState) }
    set { self.setAssociatedObject(newValue, forKey: &AssociatedKey.currentStateKey) }
  }
  
  public func makeStreamCycle() -> Observable<State> {
    let mutation = _action
      .withUnretained(self)
      .flatMap { owner, action in
        owner.mutate(action: action)
      }
    let transformedMutation = self.transform(mutation: mutation)
    let state = transformedMutation
      .scan(self.initalState) { [weak self] state, mutation -> State in
        guard let self else { return state }
        return self.reduce(state: state, mutation: mutation)
      }
      .do(onNext: { [weak self] state in
        self?.currentState = state
      })
      .replay(1)
    
    state
      .connect()
      .disposeOnDeactivate(interactor: self)
    
    return state
  }
  
  public func mutate(action: Action) -> Observable<Mutation> {
    return .empty()
  }
  
  public func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
    return mutation
  }
  
  public func reduce(state: State, mutation: Mutation) -> State {
    return state
  }
}
