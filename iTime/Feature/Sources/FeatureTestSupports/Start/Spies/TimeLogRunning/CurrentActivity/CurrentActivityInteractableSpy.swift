//
//  File.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import RIBsTestSupport
import StartImpl
import Start

public class CurrentActivityInteractableSpy:
  InteractableMock,
  CurrentActivityInteractable
{
  public var routerSetCallCount: Int = 0
  public var router: CurrentActivityRouting? { didSet { self.routerSetCallCount += 1 }}
  public var listenerSetCallCount: Int = 0
  public var listener: CurrentActivityListener? { didSet { self.listenerSetCallCount += 1 }}
}
