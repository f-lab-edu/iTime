//
//  File.swift
//
//
//  Created by 이상헌 on 11/10/23.
//

import UIKit

// MARK: - BookmarkTagsCollectionViewAdapterDataSource

public protocol BookmarkTagsCollectionViewAdapterDataSource: AnyObject {
  func numberOfItems() -> Int
  func configurationData(at index: Int) -> String
}

public protocol BookmarkCollectionViewCellDelegate: AnyObject {
  func didTapTagCell()
}

// MARK: - BookmarkTagsCollectionViewAdapter

public final class BookmarkTagsCollectionViewAdapter: NSObject {
  
  // MARK: - Constants
  
  private enum Metric {
    static let itemHorizontalMargin: CGFloat = 6
    static let itemHorizontalInset: CGFloat = 6
    static let minimumLineSpacing: CGFloat = 10
    static let sectionVerticalInset: CGFloat = 10
  }
  
  // MARK: - Properties
  
  weak var adapterDataSource: BookmarkTagsCollectionViewAdapterDataSource?
  weak var delegate: BookmarkCollectionViewCellDelegate?
  
  private var sectionInset: UIEdgeInsets {
    UIEdgeInsets(
      top: Metric.sectionVerticalInset,
      left: Metric.itemHorizontalMargin,
      bottom: Metric.sectionVerticalInset,
      right: Metric.itemHorizontalMargin
    )
  }
  
  public init(
    collectionView: UICollectionView,
    adapterDataSource: BookmarkTagsCollectionViewAdapterDataSource?,
    delegate: BookmarkCollectionViewCellDelegate?,
    alignedCollectionViewFlowLayout: UICollectionViewFlowLayout
  ) {
    super.init()
    let layout = alignedCollectionViewFlowLayout
    layout.minimumInteritemSpacing = Metric.itemHorizontalInset
    layout.minimumLineSpacing = Metric.minimumLineSpacing
    collectionView.setCollectionViewLayout(layout, animated: false)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.allowsMultipleSelection = false
    self.adapterDataSource = adapterDataSource
    self.delegate = delegate
    collectionView.register(BookmarkTagCell.self)
  }
  
}

// MARK: - UICollectionViewDataSource

extension BookmarkTagsCollectionViewAdapter: UICollectionViewDataSource {
  public func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return adapterDataSource?.numberOfItems() ?? 0
  }
  
  public func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeue(BookmarkTagCell.self, indexPath: indexPath)
    cell.configure(by: adapterDataSource?.configurationData(at: indexPath.row) ?? "")
    
    return cell
  }
}

// MARK: - UICollectionViewDelegate

extension BookmarkTagsCollectionViewAdapter: UICollectionViewDelegate {
  public func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    delegate?.didTapTagCell()
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension BookmarkTagsCollectionViewAdapter: UICollectionViewDelegateFlowLayout {
  public func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    guard let data = adapterDataSource?.configurationData(at: indexPath.row) else { return .zero }
    let labelWidthSize = data.width(
      withConstrainedHeight: 24.0,
      font: UIFont.custom(.regular, 16)
    )
    return .init(
      width: labelWidthSize + 36,
      height: 32
    )
  }
  
  public func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    insetForSectionAt section: Int
  ) -> UIEdgeInsets {
    return sectionInset
  }
}
