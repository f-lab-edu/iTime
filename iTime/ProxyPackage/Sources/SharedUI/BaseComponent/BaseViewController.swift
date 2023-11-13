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

open class BaseViewController:
  UIViewController,
  HasSetupConstraints,
  HasDetachAction,
  HasAlertable,
  HasDisposeBag
{
  
  // MARK: Views
  
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
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    print(type(of: self))
  }
  
  // MARK: - View LifeCycle
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    view.setNeedsUpdateConstraints()
    view.backgroundColor = .white
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
    //self.resignFirstResponder()
    self.view.endEditing(true)
  }
  
  // MARK: - objc
  
  public func addNotificationObserver() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillHide),
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
  }
  
  public func removeNotificationObserver() {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func keyboardWillShow(notification: Notification) {
    keyboardHandling(notification: notification, isShowing: true)
  }
  
  
  @objc func keyboardWillHide(notification: Notification) {
    keyboardHandling(notification: notification, isShowing: false)
  }
  
  private func keyboardHandling(notification: Notification, isShowing: Bool) {
    let info = notification.userInfo!
    let kbHeight = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
    if isShowing {
      bottomConstraint?.update(offset: -kbHeight)
    } else {
      bottomConstraint?.update(offset: 0)
    }
    let duration: TimeInterval = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
    UIView.animate(withDuration: duration) { self.view.layoutIfNeeded() }
  }
  
}

