//
//  ColorPickerInteractor.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs
import RxSwift

import ColorPicker

// MARK: - ColorPickerPresentable

protocol ColorPickerPresentable: Presentable {
  var listener: ColorPickerPresentableListener? { get set }
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
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: ColorPickerPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
}
