//
//  LogEntryCreationViewController.swift
//
//
//  Created by 이상헌 on 2023/11/05.
//

import UIKit

import RIBs
import RxSwift

import SharedUI
import AppFoundation

// MARK: - LogEntryCreationPresentableListener

protocol LogEntryCreationPresentableListener:
  AnyObject,
  BookmarkCollectionViewCellDelegate,
  BookmarkTagsCollectionViewAdapterDataSource {
  func settingButtonTapAction()
  func encouragingBoxTapAction()
  func bookmarkTagEditorTapAction()
  func editorRoutingButtonTapAction()
  func startButtonTapAction()
}

// MARK: - LogEntryCreationViewController

final class LogEntryCreationViewController:
  BaseViewController,
  LogEntryCreationPresentable,
  LogEntryCreationViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    static let todayDateBarHeight: CGFloat = 52
    static let encouragingBoxViewHeight: CGFloat = 60
    static let buttonsLeadingTrailingMargin: CGFloat = 24
    static let buttonsHeight: CGFloat = 52
    static let startButtonsTopMargin: CGFloat = 12
    static let startButtonsBottomMargin: CGFloat = 100
    static let buttonsRadious: CGFloat = 8
    static let bookmarkTagsTopMargin: CGFloat = 48
    static let bookmarkTagsBottomMargin: CGFloat = 48
    static let bookmarkTagsViewLeadingTrailingInset: CGFloat = 24
  }
  
  // MARK: - Properties
  
  weak var listener: LogEntryCreationPresentableListener?
  
  // MARK: - UI Components
  
  private let todayDateBar = TodayDateBar().builder
    .backgroundColor(.clear)
    .build()
  
  private let encouragingBoxView = EncouragingBoxView()
  
  private lazy var bookmarkTagsView = BookmarkTagsView(listener: listener)
  
  private let editorRoutingButton = UIButton().builder
    .set(\.layer.cornerRadius, to: Metric.buttonsRadious)
    .backgroundColor(.black90)
    .with {
      $0.setTitle("지금 내가 할 것은...", for: .normal)
      $0.setTitleColor(.black60, for: .normal)
    }
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
  }
  
}

// MARK: Bind Actions

extension LogEntryCreationViewController {
  private func bindActions() {
    bindSettingButtonTapAction()
    bindEncouragingBoxTapAction()
    bindEncouragingBoxCloseButtonTapAction()
    bindBookmarkTagsEditButtonTapAction()
    bindEdtiorRoutingButtonTapAction()
    bindStartButtonTapAction()
  }
  
  private func bindSettingButtonTapAction() {
    todayDateBar.settingButton.rx.tap
      .preventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in owner.listener?.settingButtonTapAction() }
      .disposed(by: disposeBag)
  }
  
  private func bindEncouragingBoxTapAction() {
    Observable.merge(
      encouragingBoxView.guideLabel.rx.tapGestureWithPreventDuplication(),
      encouragingBoxView.rightAccessoryImageView.rx.tapGestureWithPreventDuplication()
    )
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in owner.listener?.encouragingBoxTapAction() }
      .disposed(by: disposeBag)
  }
  
  private func bindEncouragingBoxCloseButtonTapAction() {
    encouragingBoxView.closeButton.rx.tap
      .preventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in print("close") }
      .disposed(by: disposeBag)
  }
  
  private func bindBookmarkTagsEditButtonTapAction() {
    bookmarkTagsView.bookmarkEditorButtonLabel.rx
      .tapGestureWithPreventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in owner.listener?.bookmarkTagEditorTapAction() }
      .disposed(by: disposeBag)
  }
  
  private func bindEdtiorRoutingButtonTapAction() {
    editorRoutingButton.rx.tap
      .preventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in owner.listener?.editorRoutingButtonTapAction() }
      .disposed(by: disposeBag)
  }
  
  private func bindStartButtonTapAction() {
    startButton.rx.tap
      .preventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in owner.listener?.startButtonTapAction() }
      .disposed(by: disposeBag)
  }
}

// MARK: - Layout

extension LogEntryCreationViewController {
  private func setupUI() {
    view.addSubview(todayDateBar)
    view.addSubview(encouragingBoxView)
    view.addSubview(bookmarkTagsView)
    view.addSubview(editorRoutingButton)
    view.addSubview(startButton)
    
    layout()
  }
  
  private func layout() {
    makeTodayDateBarConstraints()
    makeEncouragingBoxViewConstraints()
    makeBookmarkTagsViewConstraints()
    makeEditorRoutingButtonConstraints()
    makeStartButtonConstraints()
  }
  
  private func makeTodayDateBarConstraints() {
    todayDateBar.snp.makeConstraints {
      $0.top.equalToSuperview().offset(Layout.safeAreaTopHeight)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(Metric.todayDateBarHeight)
    }
  }
  
  private func makeEncouragingBoxViewConstraints() {
    encouragingBoxView.snp.makeConstraints {
      $0.top.equalTo(todayDateBar.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(Metric.encouragingBoxViewHeight)
    }
  }
  
  private func makeEditorRoutingButtonConstraints() {
    editorRoutingButton.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview().inset(Metric.buttonsLeadingTrailingMargin)
      $0.height.equalTo(Metric.buttonsHeight)
    }
  }
  
  private func makeStartButtonConstraints() {
    startButton.snp.makeConstraints {
      $0.height.leading.trailing.equalTo(editorRoutingButton)
      $0.top.equalTo(editorRoutingButton.snp.bottom).offset(Metric.startButtonsTopMargin)
      $0.bottom.greaterThanOrEqualToSuperview().offset(-Metric.startButtonsBottomMargin).priority(.high)
    }
  }
  
  private func makeBookmarkTagsViewConstraints() {
    bookmarkTagsView.snp.makeConstraints {
      $0.bottom.greaterThanOrEqualTo(editorRoutingButton.snp.top).offset(-Metric.bookmarkTagsBottomMargin).priority(.low)
      $0.top.greaterThanOrEqualTo(encouragingBoxView.snp.bottom).offset(Metric.bookmarkTagsTopMargin).priority(.low)
      $0.centerY.equalToSuperview()
      $0.leading.trailing.equalToSuperview().inset(Metric.bookmarkTagsViewLeadingTrailingInset)
    }
  }
  
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  let vc = LogEntryCreationViewController()
  return vc
}
#endif
