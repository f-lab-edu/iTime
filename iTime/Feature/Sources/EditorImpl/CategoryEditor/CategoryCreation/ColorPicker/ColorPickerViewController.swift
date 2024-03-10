//
//  ColorPickerViewController.swift
//
//
//  Created by 이상헌 on 12/31/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI

// MARK: - ColorPickerPresentableListener

protocol ColorPickerPresentableListener: AnyObject {
  func didTapColorButton(_ index: Int, _ hex: String)
}

// MARK: - ColorPickerViewController

final class ColorPickerViewController:
  BaseViewController,
  ColorPickerPresentable,
  ColorPickerViewControllable
{
  
  // MARK: - Constants
  
  private enum Metric {
    static let circleViewSize: CGFloat = 12.0
    static let colorStackViewSpacing: CGFloat = 20.0
    static let colorStackViewTopMargin: CGFloat = 12.0
  }
  
  // MARK: - Properties
  
  weak var listener: ColorPickerPresentableListener?
  
  // MARK: - UI Components
  
  private var buttons: [UIButton]
  
  private let sectionTitleLabel = UILabel().builder
    .text("색상")
    .textColor(.black40)
    .font(.custom(.regular, 16))
    .build()
  
  private let colorStackView = UIStackView().builder
    .axis(.horizontal)
    .spacing(Metric.colorStackViewSpacing)
    .alignment(.fill)
    .distribution(.fillEqually)
    .build()
  
  // MARK: - View LifeCycle
  
  init(buttons: [UIButton] = []) {
    self.buttons = buttons
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupButtons()
  }
  
  // TODO: refact
  private func setupButtons() {
    for (index, color) in [ UIColor.category1, .category2, .category3 , .category4 , .category5, .category6, .category7, .category8 ].enumerated() {
      let circleButton = CategoryColorOptionButton().builder
        .with {
          $0.configureButtonColor(with: color)
        }
        .build()
      
      circleButton.rx
        .tapWithPreventDuplication()
        .catch({ error in
          assertionFailure(error.localizedDescription)
          return .just(())
        })
        .map { try color.toHex.unwrap() }
        .asDriver(onErrorDriveWith: .empty())
        .drive(with: self) { owner, hex in
          owner.listener?.didTapColorButton(index, hex)
        }
        .disposed(by: disposeBag)
      
      buttons.append(circleButton)
      colorStackView.addArrangedSubview(circleButton)
    }
  }
  
  func categoryColors(_ colors: CategoryColors) {
    buttons[safe: 0]?.isSelected = colors.contains(.gray)
    buttons[safe: 1]?.isSelected = colors.contains(.red)
    buttons[safe: 2]?.isSelected = colors.contains(.yellow)
    buttons[safe: 3]?.isSelected = colors.contains(.green)
    buttons[safe: 4]?.isSelected = colors.contains(.greenblue)
    buttons[safe: 5]?.isSelected = colors.contains(.blue)
    buttons[safe: 6]?.isSelected = colors.contains(.pulple)
    buttons[safe: 7]?.isSelected = colors.contains(.greenpulple)
  }
  
}

// MARK: - Layout

extension ColorPickerViewController {
  private func setupUI() {
    view.addSubview(sectionTitleLabel)
    view.addSubview(colorStackView)
    
    layout()
  }
  
  private func layout() {
    makeSectionTitleLabelConstraints()
    makeColorStackView()
  }
  
  private func makeSectionTitleLabelConstraints() {
    sectionTitleLabel.snp.makeConstraints {
      $0.leading.top.trailing.equalToSuperview()
    }
  }
  
  private func makeColorStackView() {
    colorStackView.snp.makeConstraints {
      $0.top.equalTo(sectionTitleLabel.snp.bottom).offset(Metric.colorStackViewTopMargin)
      $0.leading.trailing.bottom.equalToSuperview()
    }
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  ColorPickerViewController()
}
#endif
