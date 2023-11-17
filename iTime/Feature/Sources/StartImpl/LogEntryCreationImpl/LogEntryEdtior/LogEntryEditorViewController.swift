//
//  LogEntryEditorViewController.swift
//
//
//  Created by 이상헌 on 11/13/23.
//

import UIKit

import RIBs
import RxSwift
import SnapKit

import SharedUI

// MARK: - LogEntryEditorPresentableListener

protocol LogEntryEditorPresentableListener: AnyObject {
}

// MARK: - LogEntryEditorViewController

final class LogEntryEditorViewController:
  BaseViewController,
  LogEntryEditorPresentable,
  LogEntryEditorViewControllable,
  KeyboardAddable,
  HasCloseButtonHeaderView,
  CloseButtonBindable
{
  
  // MARK: - Constants
  
  private enum Metric {
    static let buttonsRadious: CGFloat = 8
    static let buttonsHeight: CGFloat = 52
    static let buttonsLeadingTrailingMargin: CGFloat = 24
    static let editorRoutingButtonTopMargin: CGFloat = 58
    static let startButtonsTopMargin: CGFloat = 12
    static let startButtonsBottomMargin: CGFloat = 32
  }
  
  // MARK: - Properties
  
  weak var listener: LogEntryEditorPresentableListener?
  
  // MARK: - UI Components
  
  let headerView = CloseButtonHeaderView()
  
  private let noCategoryView = CategoryStateView().builder
    .with {
      $0.configure(by: (color: .black60, text: "No Category"))
    }
    .build()
  
  private let editorRoutingTextField = UITextField().builder
    .placeholder("지금 내가 할 것은...")
    .font(.custom(.regular, 16))
    .textAlignment(.center)
    .set(\.layer.cornerRadius, to: Metric.buttonsRadious)
    .backgroundColor(.black90)
    .build()
  
  private let startButton = UIButton().builder
    .set(\.layer.cornerRadius, to: Metric.buttonsRadious)
    .backgroundColor(.pointGreen)
    .with {
      $0.setImage(.start, for: .normal)
    }
    .build()
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindActions()
    addKeyboardObserver()
    editorRoutingTextField.becomeFirstResponder()
  }
  
  deinit {
    removeKeyboardObserver()
  }
  
  // MARK: - Private methods
  
}

// MARK: - Bind Action

extension LogEntryEditorViewController {
  private func bindActions() {
    bindCloseButtonTapAction()
    bindStartButtonTapAction()
    bindDetachAction()
  }
  
  private func bindStartButtonTapAction() {
    startButton.rx.tap
      .preventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in print("tap") }
      .disposed(by: disposeBag)
  }
  
  private func bindDetachAction() {
    detachAction
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in print("tap") }
      .disposed(by: disposeBag)
  }
}

// MARK: - Layout

extension LogEntryEditorViewController {
  private func setupUI() {
    view.addSubview(editorRoutingTextField)
    view.addSubview(startButton)
    addHeaderViewIfNeeded(to: view)
    view.addSubview(noCategoryView)
    
    layout()
  }
  
  private func layout() {
    makeEditorRoutingTextFieldConstraints()
    makeStartButtonConstraints()
    makeHeaderViewConstraintsIfNeeded()
    makeNoCategoryViewConstraints()
  }
  
  private func makeEditorRoutingTextFieldConstraints() {
    editorRoutingTextField.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(Metric.buttonsLeadingTrailingMargin)
      $0.height.equalTo(Metric.buttonsHeight)
    }
  }
  
  private func makeStartButtonConstraints() {
    startButton.snp.makeConstraints {
      $0.height.leading.trailing.equalTo(editorRoutingTextField)
      $0.top.equalTo(editorRoutingTextField.snp.bottom).offset(Metric.startButtonsTopMargin)
      bottomConstraint = $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-Metric.startButtonsBottomMargin).constraint
    }
  }
  
  private func makeNoCategoryViewConstraints() {
    noCategoryView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(14)
      $0.centerX.equalToSuperview()
    }
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  LogEntryEditorViewController()
}
#endif
