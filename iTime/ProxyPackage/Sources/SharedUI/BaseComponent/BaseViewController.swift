//
//  BaseCollectionView.swift
//  RibsReactorkitClone
//
//  Created by sangheon on 2023/04/16.
//

import UIKit

import RxSwift
import RxRelay
import SnapKit
import RIBs

open class BaseViewController:
  UIViewController,
  HasSetupConstraints,
  HasDetachAction,
  HasAlertable,
  HasDisposeBag
{
  
  // MARK: Properties
  
  public let detachAction = PublishRelay<Void>()
  public var disposeBag: DisposeBag = DisposeBag()
  public var bottomConstraint: Constraint? = nil
  
  private(set) var didSetupConstrints: Bool = false
  
  // MARK: - init & deinit
  
  public init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  public required convenience init?(coder aDecoder: NSCoder) {
    assertionFailure("init(coder:) has not been implemented")
    self.init()
  }
  
  deinit {
    print(type(of: self))
  }
  
  // MARK: - View LifeCycle
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    view.setNeedsUpdateConstraints()
    view.backgroundColor = .black200
    navigationController?.navigationBar.isHidden = true
  }
  
  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  open override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    guard isMovingToParent || isBeingDismissed else { return }
    self.detachAction.accept(Void())
  }
  
  // MARK: Layout Constraints
  
  open override func updateViewConstraints() {
    self.setupConstraintsIfNeeded()
    super.updateViewConstraints()
  }
  
  func setupConstraints() {
    // override
  }
  
  // MARK: Private
  
  private func setupConstraintsIfNeeded() {
    guard !self.didSetupConstrints else { return }
    self.setupConstraints()
    self.didSetupConstrints = true
  }
  
  open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  // MARK: - objc
  
  @objc func keyboardWillShow(notification: Notification) {
    let info = notification.userInfo ?? [:]
    guard let kbHeight = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else { return }
    bottomConstraint?.update(offset: -kbHeight)
    animateKeyboard(info: info)
  }
  
  @objc func keyboardWillHide(notification: Notification) {
    let info = notification.userInfo ?? [:]
    bottomConstraint?.update(offset: -32)
    animateKeyboard(info: info)
  }
  
  private func animateKeyboard(info: [AnyHashable: Any]) {
    guard let duration: TimeInterval = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue else { return }
    UIView.animate(withDuration: duration) { self.view.layoutIfNeeded() }
  }
}

