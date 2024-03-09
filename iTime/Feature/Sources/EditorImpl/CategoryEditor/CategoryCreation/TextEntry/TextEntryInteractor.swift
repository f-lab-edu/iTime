//
//  TextEntryInteractor.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs
import RxSwift

import Editor

// MARK: - TextEntryPresentable

protocol TextEntryPresentable: Presentable {
  var listener: TextEntryPresentableListener? { get set }
  func updateCategoryTextField(with text: String)
}

// MARK: - TextEntryInteractor

final class TextEntryInteractor: 
  PresentableInteractor<TextEntryPresentable>,
  TextEntryInteractable,
  TextEntryPresentableListener
{
  
  // MARK: - Properties
  
  weak var router: TextEntryRouting?
  weak var listener: TextEntryListener?
  
  // MARK: - Initialization & DeInitialization
  
  override init(presenter: TextEntryPresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  // MARK: - LifeCycle
  
  override func didBecomeActive() {
    super.didBecomeActive()
  }
  
  func loadData() {
    presenter.updateCategoryTextField(with: "") // TODO: fill data
  }
  
  func didChangeCategoryTextField(_ text: String) {
    listener?.currentCategoryTitle(with: text)
  }
}
