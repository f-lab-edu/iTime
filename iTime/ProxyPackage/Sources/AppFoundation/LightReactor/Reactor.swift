//
//  File.swift
//
//
//  Created by 이상헌 on 12/5/23.
//

import RxSwift
import RIBs

// MARK: - Reactor

public protocol LightReactor {
  
  associatedtype Action
  
  associatedtype Mutation = Action
  
  associatedtype State
  
  var action: PublishSubject<Action> { get }
  
  var initalState: State { get }
  
  var state: Observable<State> { get }
  
  func sendAction(_ action: Action)
  
  func mutate(action: Action) -> Observable<Mutation>
    
  func transform(mutation: Observable<Mutation>) -> Observable<Mutation>
  
  func reduce(state: State, mutation: Mutation) -> State
}

// MARK: - Reactor Impl

extension LightReactor where Self: Interactor {
  
  public var action: PublishSubject<Action> {
    _ = self.state
    
    return self.action
  }
  
  public var state: Observable<State> {
    return self.makeStreamCycle()
  }
  
  public func sendAction(_ action: Action) {
    self.action.on(.next(action))
  }
  
  public func makeStreamCycle() -> Observable<State> {
    let mutation = action
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
    return .empty()
  }
  
  public func reduce(state: State, mutation: Mutation) -> State {
    return state
  }
}
