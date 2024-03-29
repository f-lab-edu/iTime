//
//  UICollectionViewExtension.swift
//  RibsReactorkitClone
//
//  Created by sangheon on 2023/04/22.
//

import UIKit

extension UICollectionView {
  public func register<Cell: UICollectionViewCell>(_: Cell.Type) where Cell: Reusable {
    self.register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
  }

  public func register<View: UICollectionReusableView>(_: View.Type) where View: Reusable & HasElementKind {
    self.register(
      View.self,
      forSupplementaryViewOfKind: View.elementKind,
      withReuseIdentifier: View.identifier
    )
  }

  public func dequeue<Cell: UICollectionViewCell>(_: Cell.Type, indexPath: IndexPath) -> Cell where Cell: Reusable {
    if let cell = dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as? Cell {
      return cell
    } else {
      fatalError("Could not cast value of type 'UICollectionViewCell' to '\(String(describing: Cell.self))'")
    }
  }

  public func dequeue<View: UICollectionReusableView>(
    _: View.Type,
    indexPath: IndexPath
  ) -> View where View: Reusable & HasElementKind {
    if let view = dequeueReusableSupplementaryView(
      ofKind: View.elementKind,
      withReuseIdentifier: View.identifier,
      for: indexPath
    ) as? View {
      return view
    } else {
      fatalError("Could not cast value of type 'UICollectionReusableView' to '\(String(describing: View.self))'")
    }
  }
}
