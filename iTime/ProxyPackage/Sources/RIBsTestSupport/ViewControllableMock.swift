//
//  File.swift
//  
//
//  Created by 이상헌 on 11/19/23.
//

import UIKit

import RIBs

open class ViewControllableMock: UIViewController, ViewControllable {
  public init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required public init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  public var presentCallCount = 0 
  public override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
    presentCallCount += 1
  }
  
  public var dismissCallCount = 0
  public override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
    dismissCallCount += 1
  }
  
}
