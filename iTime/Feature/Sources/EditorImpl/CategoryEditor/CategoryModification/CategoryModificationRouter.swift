//
//  CategoryModificationRouter.swift
//  
//
//  Created by 이상헌 on 3/10/24.
//

import RIBs

import Editor

// MARK: - CategoryModificationInteractable

protocol CategoryModificationInteractable: 
  Interactable,
  TextEntryListener,
  ColorPickerListener
{
  var router: CategoryModificationRouting? { get set }
  var listener: CategoryModificationListener? { get set }
}

// MARK: - CategoryModificationViewControllable

protocol CategoryModificationViewControllable: ViewControllable {
  func addTextEntry(_ view: ViewControllable)
  func addColorPicker(_ view: ViewControllable)
}

// MARK: - CategoryModificationRouter

final class CategoryModificationRouter:
  ViewableRouter<CategoryModificationInteractable,
  CategoryModificationViewControllable>,
  CategoryModificationRouting
{
  
  // MARK: - Properties
  
  private let textEntryBuilder: TextEntryBuildable
  private var textEntryRouter: TextEntryRouting?
  
  private let colorPickerBuilder: ColorPickerBuildable
  private var colorPickerRouter: ColorPickerRouting?
  
  // MARK: - Initialization & DeInitialization
  
  init(
    interactor: CategoryModificationInteractable,
    viewController: CategoryModificationViewControllable,
    textEntryBuilder: TextEntryBuildable,
    colorPickerBuilder: ColorPickerBuildable
  ) {
    self.textEntryBuilder = textEntryBuilder
    self.colorPickerBuilder = colorPickerBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
  override func didLoad() {
    super.didLoad()
    attachTextEntryRIB()
    attachColorPickerRIB()
  }
  
  // MARK: Route methods
  
  private func attachTextEntryRIB() {
    guard textEntryRouter == nil else { return }
    let router = textEntryBuilder.build(
      withListener: interactor,
      payload: .init(categoryTitle: nil) // TODO: !!
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
