//
//  BaseCollectionView.swift
//  RibsReactorkitClone
//
//  Created by sangheon on 2023/04/16.
//

import UIKit

import RxSwift
import RxRelay

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
    
    @objc
    func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        // move the root view up by the distance of keyboard height
        self.view.frame.origin.y = 0 - keyboardSize.height
    }
    
    @objc
    func keyboardWillHide(notification: Notification) {
        // move back the root view origin to zero
        self.view.frame.origin.y = 0
    }
    
}

