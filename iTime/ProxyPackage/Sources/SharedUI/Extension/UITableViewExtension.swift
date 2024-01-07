//
//  UITableViewExtension.swift
//  RibsReactorkitClone
//
//  Created by sangheon on 2023/04/16.
//

import UIKit

extension UITableView {
  public func register<Cell: UITableViewCell>(_: Cell.Type) where Cell: Reusable {
    self.register(Cell.self, forCellReuseIdentifier: Cell.identifier)
  }

  public func register<View: UITableViewHeaderFooterView>(_: View.Type) where View: Reusable {
    self.register(View.self, forHeaderFooterViewReuseIdentifier: View.identifier)
  }

  public func dequeue<Cell: UITableViewCell>(_: Cell.Type, indexPath: IndexPath) -> Cell where Cell: Reusable {
    if let cell = dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath) as? Cell {
      return cell
    } else {
      fatalError("Could not cast value of type 'UITableViewCell' to '\(String(describing: Cell.self))'")
    }
  }

  public func dequeue<View: UITableViewHeaderFooterView>(_: View.Type) -> View where View: Reusable {
    if let view = dequeueReusableHeaderFooterView(withIdentifier: View.identifier) as? View {
      return view
    } else {
      fatalError("Could not cast value of type 'UITableViewHeaderFooterView' to '\(String(describing: View.self))'")
    }
  }
}
