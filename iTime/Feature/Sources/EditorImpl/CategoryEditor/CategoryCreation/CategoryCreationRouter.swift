//
//  CategoryCreationRouter.swift
//  
//
//  Created by 이상헌 on 12/7/23.
//

import RIBs

import Editor

// MARK: - CategoryCreationInteractable

protocol CategoryCreationInteractable:
  Interactable,
  TextEntryListener,
  ColorPickerListener
{
  var router: CategoryCreationRouting? { get set }
  var listener: CategoryCreationListener? { get set }
}

// MARK: - CategoryCreationViewControllable

protocol CategoryCreationViewControllable: ViewControllable {
  func addTextEntry(_ view: ViewControllable)
  func addColorPicker(_ view: ViewControllable)
}

// MARK: - CategoryCreationRouter

final class CategoryCreationRouter:
  ViewableRouter<CategoryCreationInteractable,
  CategoryCreationViewControllable>,
  CategoryCreationRouting
{
  
  // MARK: - Properties
  
  private let textEntryBuilder: TextEntryBuildable
  private var textEntryRouter: TextEntryRouting?
  
  private let colorPickerBuilder: ColorPickerBuildable
  private var colorPickerRouter: ColorPickerRouting?
  
  // MARK: - Initialization & DeInitialization
  
  init(
    interactor: CategoryCreationInteractable,
    viewController: CategoryCreationViewControllable,
    textEntryBuilder: TextEntryBuildable,
    colorPickerBuilder: ColorPickerBuildable
  ) {
    self.textEntryBuilder = textEntryBuilder
    self.colorPickerBuilder = colorPickerBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  override func didLoad() {
    super.didLoad()
    attachTextEntryRIB()
    attachColorPickerRIB()
  }
  
  // MARK: Route methods
  
  private func attachTextEntryRIB() {
    guard textEntryRouter == nil else { return }
    let router = textEntryBuilder.build(
      withListener: interactor
    )
    textEntryRouter = router
    attachChild(router)
    viewController.addTextEntry(router.viewControllable)
  }
  
  private func attachColorPickerRIB() {
    guard colorPickerRouter == nil else { return }
    let router = colorPickerBuilder.build(
      withListener: interactor
    )
    colorPickerRouter = router
    attachChild(router)
    viewController.addColorPicker(router.viewControllable)
  }
}
