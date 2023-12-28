//
//  File.swift
//
//
//  Created by 이상헌 on 12/28/23.
//

import RxSwift

import UIKit

public enum ActionSheetActionType {
  case addBookmark
  case delete
}

public protocol HasActionSheetable where Self: UIViewController {
  func showActionSheet() -> Observable<ActionSheetActionType>
}

extension HasActionSheetable {
  public func showActionSheet() -> Observable<ActionSheetActionType> {
    return Observable.create { [weak self] observer in
      let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
      let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
        observer.onNext(.delete)
        observer.onCompleted()
      }
      
      alertController.addAction(deleteAction)
      let okAction = UIAlertAction(title: "즐겨찾기로 설정", style: .default) { _ in
        observer.onNext(.addBookmark)
        observer.onCompleted()
      }
      alertController.addAction(okAction)
      
      let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
        observer.onCompleted()
      }
      
      alertController.addAction(cancelAction)
      self?.present(alertController, animated: true, completion: nil)
      
      return Disposables.create {
        alertController.dismiss(animated: true, completion: nil)
      }
    }
  }
}
