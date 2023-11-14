//
//  File.swift
//  
//
//  Created by 이상헌 on 11/14/23.
//

import UIKit

// MARK: - AlignedCollectionViewFlowLayout

public protocol AlignedCollectionViewFlowLayout {
  func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?
}

extension UICollectionViewFlowLayout: AlignedCollectionViewFlowLayout {}
