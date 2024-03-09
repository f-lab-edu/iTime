//
//  TextEntryViewController.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - TextEntryPresentableListener

protocol TextEntryPresentableListener: AnyObject {
  func didChangeCategoryTextField(_ text: String)
  func loadData()
}

// MARK: - TextEntryViewController

final class TextEntryViewController:
  BaseViewController,
  TextEntryPresentable,
  TextEntryViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    static let categoryTextEntryFieldRadius: CGFloat = 8.0
    static let categoryTextEntryFieldTopMargin: CGFloat = 8.0
    static let categoryTextEntryFieldHeight: CGFloat = 52.0
  }
  
  // MARK: - Properties
  
  weak var listener: TextEntryPresentableListener?
  
  // MARK: - UI Components
    
  private let categoryTitleLabel = UILabel().builder
    .text("카테고리 이름")
    .font(.custom(.regular, 16))
    .textColor(.black40)
    .build()
  
  private let categoryTextEntryField = UITextField().builder
    .set(\.layer.cornerRadius, to: 8)
    .placeholder("8자 내로 입력해 주세요")
    .leftView(UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10)))
    .leftViewMode(.always)
    .backgroundColor(.black60)
    .with {
      $0.becomeFirstResponder()
    }
    .build()
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindActions()
  }
  
}

// MARK: - Action

extension TextEntryViewController {
  private func bindActions() {
    bindDidChangeCategoryTextField()
    loadData()
  }
  
  private func loadData() {
    listener?.loadData()
  }
  
  // TODO: refact
  private func bindDidChangeCategoryTextField() {
    categoryTextEntryField.rx
      .text
      .orEmpty
      .distinctUntilChanged()
      .skip(1)
      .scan(categoryTextEntryField.text) { [weak self] (prev, current) -> String? in
        guard current.count <= 8 else { return prev }
        return self?.spaceFilteredText(prev, current)
      }
      .withUnretained(self)
      .compactMap { owner, text in
        owner.categoryTextEntryField.text = text
        return text
      }
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, text in
        owner.listener?.didChangeCategoryTextField(text)
      }
      .disposed(by: disposeBag)
  }
  
  private func spaceFilteredText(_ prev: String?, _ current: String) -> String? {
    let removeSpaceString = current.replacingOccurrences(of: " ", with: "")
    return removeSpaceString.count == current.count ? current : prev
  }
}

// MARK: - State

extension TextEntryViewController {
  func updateCategoryTextField(with text: String) {
    self.categoryTextEntryField.text = text
  }
}

// MARK: - Layout

extension TextEntryViewController {
  private func setupUI() {
    view.addSubview(categoryTitleLabel)
    view.addSubview(categoryTextEntryField)
    
    layout()
  }
  
  private func layout() {
    makeCategoryTitleLabelConstraints()
    makeCategoryTextEntryFieldConstraints()
  }
  
  private func makeCategoryTitleLabelConstraints() {
    categoryTitleLabel.snp.makeConstraints {
      $0.leading.top.equalToSuperview()
    }
  }
  
  private func makeCategoryTextEntryFieldConstraints() {
    categoryTextEntryField.snp.makeConstraints {
      $0.top.equalTo(categoryTitleLabel.snp.bottom).offset(Metric.categoryTextEntryFieldTopMargin)
      $0.height.equalTo(Metric.categoryTextEntryFieldHeight)
      $0.leading.bottom.trailing.equalToSuperview()
    }
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  TextEntryViewController()
}
#endif
