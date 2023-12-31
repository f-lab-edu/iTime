//
//  ColorPickerRouter.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs

import ColorPicker

// MARK: - ColorPickerInteractable

protocol ColorPickerInteractable: Interactable {
  var router: ColorPickerRouting? { get set }
  var listener: ColorPickerListener? { get set }
}

// MARK: - ColorPickerViewControllable

protocol ColorPickerViewControllable: ViewControllable {
}

// MARK: - ColorPickerRouter

final class ColorPickerRouter:
  ViewableRouter<ColorPickerInteractable,
  ColorPickerViewControllable>,
  ColorPickerRouting
{
  
  // MARK: - Properties
  
  // MARK: - Initialization & DeInitialization
  
  override init(
    interactor: ColorPickerInteractable,
    viewController: ColorPickerViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
}
