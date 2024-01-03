//
//  File.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import StartImpl

public final class CurrentActivityPresentableSpy: CurrentActivityPresentable {
  public var listenerSetCallCount: Int = 0
  public var listener: StartImpl.CurrentActivityPresentableListener? { didSet { self.listenerSetCallCount += 1 }}
  
  public var bindTageViewTitleHandler: (()->())?
  public var bindTagViewTitleCallCount: Int = 0
  public var bindTagViewTitleSetValue: String = String()
  public func bindTageViewTitle(_ title: String) {
    bindTagViewTitleCallCount += 1
    bindTagViewTitleSetValue = title
    bindTageViewTitleHandler?()
  }
  
  public init() {}
}
