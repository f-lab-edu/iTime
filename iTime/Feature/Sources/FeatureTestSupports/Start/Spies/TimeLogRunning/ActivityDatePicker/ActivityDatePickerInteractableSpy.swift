//
//  File.swift
//  
//
//  Created by 이상헌 on 1/2/24.
//

import Start
import StartImpl
import RIBsTestSupport

public class ActivityDatePickerInteractableSpy:
  InteractableMock,
  ActivityDatePickerInteractable {
  public var routerSetCallCounter: Int = 0
  public var router: Start.ActivityDatePickerRouting? { didSet { self.routerSetCallCounter += 1 } }
  public var listenerSetCallCounter: Int = 0
  public var listener: Start.ActivityDatePickerListener? { didSet { self.listenerSetCallCounter += 1 }}
}
