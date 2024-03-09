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
  
  private var state: ColorPickerState
  
  // MARK: - Initialization & DeInitialization
  
  init(
    initialState: ColorPickerState,
    presenter: ColorPickerPresentable
  ) {
    self.state = initialState
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  func didTapColorButton(_ index: Int, _ hex: String) {
    let element: CategoryColors.Element
    
    switch index {
    case 0: element = .gray
    case 1: element = .red
    case 2: element = .yellow
    case 3: element = .green
    case 4: element = .greenblue
    case 5: element = .blue
    case 6: element = .pulple
    case 7: element = .greenpulple
    default: element = .greenpulple
    }
    
    state.categoryColors.remove(.all)
    state.categoryColors.insert(element)
    
    presenter.categoryColors(state.categoryColors)
    listener?.currentCategoryColorHex(with: hex)
  }
}
