//
//  Constant.swift
//  omos
//
//  Created by sangheon on 2023/05/13.
//

import UIKit

public enum Device {
    public static let deviceNames: [String] = [
        "iPhone SE2",
        "iPhone 14 Pro Max"
    ]
}

public enum Layout {
  public static let safeAreaTopHeight =  (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets.top ?? .zero
  public static let safeAreaBottomHeight =  (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets.bottom ?? .zero
}
