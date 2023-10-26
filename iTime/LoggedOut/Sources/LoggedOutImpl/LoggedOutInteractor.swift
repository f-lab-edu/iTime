//
//  LoggedOutInteractor.swift
//  
//
//  Created by 이상헌 on 2023/10/26.
//

import ReactorKit
import RIBs
import RxSwift

import LoggedOut

// MARK: - LoggedOutPresentable

protocol LoggedOutPresentable: Presentable {
    var listener: LoggedOutPresentableListener? { get set }
}

// MARK: - LoggedOutInteractor

final class LoggedOutInteractor:
    PresentableInteractor<LoggedOutPresentable>,
    LoggedOutInteractable,
    LoggedOutPresentableListener,
    Reactor
{
    
    // MARK: - Reactor
    
    typealias Action = LoggedOutPresentableAction
    typealias State = LoggedOutPresentableState
    
    enum Mutation {
        
    }
    
    // MARK: - Properties
    
    weak var router: LoggedOutRouting?
    weak var listener: LoggedOutListener?
    
    let initialState: LoggedOutPresentableState
    
    // MARK: - Initialization & Deinitialization
    
    init(
        presenter: LoggedOutPresentable,
        initialState: LoggedOutPresentableState
    ) {
        self.initialState = initialState
        
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    // MARK: - LoggedOutPresentableListener
    
    func sendAction(_ action: Action) {
        self.action.on(.next(action))
    }
}

// MARK: - mutate

extension LoggedOutInteractor {
    func mutate(action: Action) -> Observable<Mutation> {
        
    }
}

// MARK: - reduce

extension LoggedOutInteractor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        return newState
    }
}
