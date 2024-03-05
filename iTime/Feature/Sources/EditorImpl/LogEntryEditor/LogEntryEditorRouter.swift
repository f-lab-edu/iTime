//
//  LogEntryEditorRouter.swift
//  
//
//  Created by 이상헌 on 11/13/23.
//

import Foundation

import RIBs

import Editor

// MARK: - LogEntryEditorInteractable

protocol LogEntryEditorInteractable: 
  Interactable,
  CategoryEditorListener
{
  var router: LogEntryEditorRouting? { get set }
  var listener: LogEntryEditorListener? { get set }
}

// MARK: - LogEntryEditorViewControllable

protocol LogEntryEditorViewControllable: ViewControllable {
}

// MARK: - LogEntryEditorRouter

final class LogEntryEditorRouter:
  ViewableRouter<LogEntryEditorInteractable,
  LogEntryEditorViewControllable>,
  LogEntryEditorRouting
{
  
  // MARK: - Properties
  
  private let categoryEditorBuilder: CategoryEditorBuildable
  private var categoryEditorRouter: CategoryEditorRouting?
  
  // MARK: - Initialization & DeInitialization
  
  init(
    interactor: LogEntryEditorInteractable,
    viewController: LogEntryEditorViewControllable,
    categoryEditorBuilder: CategoryEditorBuildable
  ) {
    self.categoryEditorBuilder = categoryEditorBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
  func attachCategoryEditorRIB(with categoryTitle: String) {
    guard categoryEditorRouter == nil else { return }
    let router = categoryEditorBuilder.build(
      with: interactor,
      title: categoryTitle
    )
    categoryEditorRouter = router
    attachChild(router)
    viewController.push(viewController: router.viewControllable, animated: true)
  }
  
  func detachCategoryEditorRIB() {
    guard let router = categoryEditorRouter else { return }
    categoryEditorRouter = nil
    detachChild(router)
    viewController.pop(router.viewControllable, animated: true)
  }
}
