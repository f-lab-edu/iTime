//
//  ColorPickerInteractor.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs
import RxSwift

import Editor

// MARK: - ColorPickerPresentable

protocol ColorPickerPresentable: Presentable {
  var listener: ColorPickerPresentableListener? { get set }
  func categoryColors(_ colors: CategoryColors)
}

// MARK: - ColorPickerInteractor

final class ColorPickerInteractor: 
  PresentableInteractor<ColorPickerPresentable>,
  ColorPickerInteractable,
  ColorPickerPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: ColorPickerRouting?
  weak var listener: ColorPickerListener?
  
  private(set) var state: ColorPickerState
  
  // MARK: - Initialization & DeInitialization
  
  init(
    initialState: ColorPickerState,
    presenter: ColorPickerPresentable
  ) {
    self.state = initialState
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  func didTapColorButton(_ index: Int, _ hex: String = "") {
    updateCategoryColors(element: targetElement(index, hex))
    presenter.categoryColors(state.categoryColors)
    listener?.currentCategoryColorHex(with: hex)
  }
  
  private func updateCategoryColors(element: CategoryColors.Element) {
    state.categoryColors.remove(.all)
    state.categoryColors.insert(element)
  }
  
  private func targetElement(_ index: Int, _ hex: String) -> CategoryColors.Element {
    switch index {
    case 0: return .gray
    case 1: return .red
    case 2: return .yellow
    case 3: return .green
    case 4: return .greenblue
    case 5: return .blue
    case 6: return .pulple
    case 7: return .greenpulple
    default: return .greenpulple
    }
  }
}
