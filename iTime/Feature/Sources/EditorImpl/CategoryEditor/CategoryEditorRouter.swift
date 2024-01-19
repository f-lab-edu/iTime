//
//  CategoryEditorRouter.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import RIBs

import Editor
import Start

// MARK: - CategoryEditorInteractable

public protocol CategoryEditorInteractable: 
  Interactable,
  CurrentActivityListener,
  CategoryListListener,
  CategoryCreationListener
{
  var router: CategoryEditorRouting? { get set }
  var listener: CategoryEditorListener? { get set }
}

// MARK: - CategoryEditorViewControllable

public protocol CategoryEditorViewControllable: ViewControllable {
  func addCurrentActivity(_ view: ViewControllable)
  func addCategoryList(_ view: ViewControllable)
}

// MARK: - CategoryEditorRouter

final class CategoryEditorRouter:
  ViewableRouter<CategoryEditorInteractable,
  CategoryEditorViewControllable>,
  CategoryEditorRouting
{
  
  // MARK: - Properties
  
  private let currentActivityBuilder: CurrentActivityBuildable
  private var currentActivityRouter: CurrentActivityRouting?
  
  private let categoryListBuilder: CategoryListBuildable
  private var categoryListRouter: CategoryListRouting?
  
  private let categoryCreationBuilder: CategoryCreationBuildable
  private var categoryCreationRouter: CategoryCreationRouting?
  
  // MARK: - Initialization & DeInitialization
  
  init(
    interactor: CategoryEditorInteractable,
    viewController: CategoryEditorViewControllable,
    currentActivityBuilder: CurrentActivityBuildable,
    categoryListBuilder: CategoryListBuildable,
    categoryCreationBuilder: CategoryCreationBuildable
  ) {
    self.currentActivityBuilder = currentActivityBuilder
    self.categoryListBuilder = categoryListBuilder
    self.categoryCreationBuilder = categoryCreationBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  override func didLoad() {
    super.didLoad()
    attachCurrentActivityRIB()
    attachCategoryListRIB()
  }
  
  // MARK: Route methods
  
  func attachCurrentActivityRIB() {
    guard currentActivityRouter == nil else { return }
    let router = currentActivityBuilder.build(
      withListener: interactor
    )
    currentActivityRouter = router
    attachChild(router)
    viewController.addCurrentActivity(router.viewControllable)
  }
  
  func attachCategoryListRIB() {
    guard categoryListRouter == nil else { return }
    let router = categoryListBuilder.build(
      withListener: interactor
    )
    categoryListRouter = router
    attachChild(router)
    viewController.addCategoryList(router.viewControllable)
  }
  
  func attachCategoryCreationRIB() {
    guard categoryCreationRouter == nil else { return }
    let router = categoryCreationBuilder.build(
      withListener: interactor
    )
    categoryCreationRouter = router
    attachChild(router)
    viewController.push(viewController: router.viewControllable)
  }
  
}
