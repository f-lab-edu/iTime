//
//  LoggedOutStateAction.swift
//  
//
//  Created by 이상헌 on 2023/10/26.
//

import RxSwift

import LoggedOut

// MARK: - LoggedOutPresentableState

struct LoggedOutPresentableState {
    
}

// MARK: - LoggedOutPresentableAction

enum LoggedOutPresentableAction {
    
}

// MARK: - LoggedOutPresentableListener

protocol LoggedOutPresentableListener: AnyObject {
    typealias Action = LoggedOutPresentableAction
    typealias State = LoggedOutPresentableState
    
    func sendAction(_ action: Action)
    var state: Observable<State> { get }
}
