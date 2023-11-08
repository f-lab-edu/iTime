//
//  LogEntryCreationViewController.swift
//  
//
//  Created by 이상헌 on 2023/11/05.
//

import UIKit

import RIBs
import RxSwift


protocol LogEntryCreationPresentableListener: AnyObject {
}

final class LogEntryCreationViewController:
  UIViewController,
  LogEntryCreationPresentable,
  LogEntryCreationViewControllable
{

    weak var listener: LogEntryCreationPresentableListener?
}
