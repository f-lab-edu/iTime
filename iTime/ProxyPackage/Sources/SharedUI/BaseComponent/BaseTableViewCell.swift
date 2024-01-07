//
//  BaseTableViewCell.swift
//  RibsReactorkitClone
//
//  Created by sangheon on 2023/04/19.
//

import UIKit

import RxSwift

open class BaseTableViewCell:
    UITableViewCell,
    Reusable,
    HasDisposeBag
{
    
    // MARK: Properties
    
    public var disposeBag = DisposeBag()
    
    private(set) var didSetupConstrints: Bool = false
    
    // MARK: - initialization & Deinitialization
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
      assertionFailure("init(coder:) has not been implemented")
      super.init(coder: coder)
    }
    
    // MARK: - Inheritance
    
    open override func prepareForReuse() {
        super.prepareForReuse()
      disposeBag = DisposeBag()
    }
    
    // MARK: Layout Constraints
    
    open override func updateConstraints() {
        self.setupConstraintsIfNeeded()
        super.updateConstraints()
    }
    
    open func initialize() {
        // Override point
        setNeedsUpdateConstraints()
        selectionStyle = .none
        backgroundColor = .white
    }
    
    open func setupConstraints() {
        // Override here
    }
    
    private func setupConstraintsIfNeeded() {
        guard !self.didSetupConstrints else { return }
        self.setupConstraints()
        self.didSetupConstrints = true
    }

}
