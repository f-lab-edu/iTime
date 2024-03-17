//
//  CategoryEditorRouter.swift
//  
//
//  Created by 이상헌 on 11/25/23.
//

import RIBs

import Entities
import Editor
import Start

// MARK: - CategoryEditorInteractable

public protocol CategoryEditorInteractable: 
  Interactable,
  CurrentActivityListener,
  CategoryListListener,
  CategoryCreationListener,
  CategoryModificationListener
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
  
  private let categoryModificationBuilder: CategoryModificationBuildable
  private var categoryModificationRouter: CategoryModificationRouting?
  
  // MARK: - Initialization & DeInitialization
  
  init(
    interactor: CategoryEditorInteractable,
    viewController: CategoryEditorViewControllable,
    currentActivityBuilder: CurrentActivityBuildable,
    categoryListBuilder: CategoryListBuildable,
    categoryModificationBuilder: CategoryModificationBuildable,
    categoryCreationBuilder: CategoryCreationBuildable
  ) {
    self.currentActivityBuilder = currentActivityBuilder
    self.categoryListBuilder = categoryListBuilder
    self.categoryModificationBuilder = categoryModificationBuilder
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
  
  func detachCategoryCreationRIB() {
    guard let router = categoryCreationRouter else { return }
    categoryCreationRouter = nil
    detachChild(router)
    viewController.pop(router.viewControllable)
  }
  
  func attachCategoryModificationRIB(with category: Category) {
    guard categoryModificationRouter == nil else { return }
    let router = categoryModificationBuilder.build(
      withListener: interactor
    )
    categoryModificationRouter = router
    attachChild(router)
    viewController.push(viewController: router.viewControllable)
  }
  
  func detachCategoryModificationRIB() {
    guard let router = categoryModificationRouter else { return }
    categoryModificationRouter = nil
    detachChild(router)
    viewController.pop(router.viewControllable)
  }
  
}
