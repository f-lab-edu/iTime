//
//  File.swift
//  
//
//  Created by 이상헌 on 11/11/23.
//

import UIKit

public class DynamicHeightCollectionView: UICollectionView {
  public override var intrinsicContentSize: CGSize {
      let height = self.contentSize.height + self.contentInset.top + self.contentInset.bottom
      return CGSize(width: self.contentSize.width, height: height)
  }
  
  public override func layoutSubviews() {
      self.invalidateIntrinsicContentSize()
      super.layoutSubviews()
  }
}
