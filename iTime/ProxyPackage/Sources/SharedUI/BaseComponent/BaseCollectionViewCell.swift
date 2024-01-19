//
//  BaseCollectionViewCell.swift
//  RibsReactorkitClone
//
//  Created by sangheon on 2023/04/22.
//
import UIKit

import RxSwift

open class BaseCollectionViewCell:
  UICollectionViewCell,
  BaseViewable,
  Reusable,
  HasDisposeBag
{

  // MARK: - Properties

  public var disposeBag = DisposeBag()

  private(set) var didSetupConstrints: Bool = false

  // MARK: - Initialization & Deinitialization

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.initialize()
  }

  @available(*, unavailable)
  required public init?(coder aDecoder: NSCoder) {
    assertionFailure("init(coder:) has not been implemented")
    super.init(coder: aDecoder)
  }

  // MARK: - Inheritance

  public override func prepareForReuse() {
    super.prepareForReuse()
    disposeBag = DisposeBag()
  }

  // MARK: - Layout Constraints

  public override func updateConstraints() {
    self.setupConstraintsIfNeeded()
    super.updateConstraints()
  }

  // MARK: - Internal methods

  open func initialize() {
    // Override point
    setNeedsUpdateConstraints()
  }

  open func setupConstraints() {
    // Override here
  }

  // MARK: - Private methods

  private func setupConstraintsIfNeeded() {
    guard !self.didSetupConstrints else { return }
    self.setupConstraints()
    self.didSetupConstrints = true
  }
}
