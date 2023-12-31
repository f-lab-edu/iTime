//
//  TextEntryRouter.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs

import Editor

// MARK: - TextEntryInteractable

protocol TextEntryInteractable: Interactable {
  var router: TextEntryRouting? { get set }
  var listener: TextEntryListener? { get set }
}

// MARK: - TextEntryViewControllable

protocol TextEntryViewControllable: ViewControllable {
}

// MARK: - TextEntryRouter

final class TextEntryRouter:
  ViewableRouter<TextEntryInteractable,
  TextEntryViewControllable>,
  TextEntryRouting
{
  
  // MARK: - Properties
  
  // MARK: - Initialization & DeInitialization
  
  override init(
    interactor: TextEntryInteractable,
    viewController: TextEntryViewControllable
  ) {
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  // MARK: Route methods
  
}
