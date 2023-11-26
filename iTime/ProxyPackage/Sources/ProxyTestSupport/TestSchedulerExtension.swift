//
//  Operators.swift
//  BarrierFreeTests
//
//  Created by 이상헌 on 2022/12/05.
//

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
