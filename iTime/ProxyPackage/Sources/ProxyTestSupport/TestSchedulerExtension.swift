//
//  Operators.swift
//  BarrierFreeTests
//
//  Created by 이상헌 on 2022/12/05.
//

import Foundation

import RxSwift
import RxTest

/// https://fivenyc.medium.com/testing-rxswift-code-how-i-learned-to-stop-worrying-and-love-writing-unit-tests-part-2-a39b61906e55
extension TestScheduler {
/**
    Creates a `TestableObserver` instance which immediately subscribes to the `source`
    */
   public func record<O: ObservableConvertibleType>(
       _ source: O,
       disposeBag: DisposeBag
   ) -> TestableObserver<O.Element> {
       let observer = self.createObserver(O.Element.self)
       source
           .asObservable()
           .subscribe(observer)
           .disposed(by: disposeBag)
       return observer
   }
}

// https://sudo-park.medium.com/swift-unittest%EC%97%90%EC%84%9C-rxswift-concurrency-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0-75c0907a3423
public extension ObservableType {
    
    func values(
        with timeoutMillis: TimeInterval,
        scheduler: SchedulerType = MainScheduler.instance
    ) -> AsyncThrowingStream<Element, Error> {
        
        let timeout: RxTimeInterval = .milliseconds(Int(timeoutMillis * 1000))
        return self.timeout(timeout, scheduler: scheduler)
            .values
    }
}
