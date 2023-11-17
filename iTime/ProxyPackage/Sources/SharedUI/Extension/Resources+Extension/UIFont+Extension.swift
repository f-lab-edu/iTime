//
//  File.swift
//
//
//  Created by 이상헌 on 11/17/23.
//

import UIKit

public func registerCommonFonts() {
  let fonts = [
    "SUIT-Bold",
    "SUIT-Heavy",
    "SUIT-Light",
    "SUIT-Medium",
    "SUIT-Regular",
    "SUIT-SemiBold",
    "SUIT-Thin"
  ]
  
  for font in fonts {
    UIFont.registerFont(bundle: Bundle.module, fontName: font)
  }
}

extension UIFont {
  /// 폰트 등록시키기
  /// - Parameters:
  ///   - bundle: Bundle
  ///   - fontName: String
  static func registerFont(bundle: Bundle, fontName: String) {
    guard let url = bundle.url(forResource: fontName, withExtension: "otf") else {
      assertionFailure()
      return
    }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }
}

extension UIFont {
  public enum Suit {
    case thin
    case light
    case regular
    case medium
    case bold
    case semiBold
    case heavy
    
    var name: String {
      switch self {
      case .thin:       return "SUIT-Thin"
      case .light:      return "SUIT-Light"
      case .regular:    return "SUIT-Regular"
      case .medium:     return "SUIT-Medium"
      case .bold:       return "SUIT-Bold"
      case .semiBold:   return "SUIT-SemiBold"
      case .heavy:      return "SUIT-Heavy"
      }
    }
    
    var type: UIFont.Weight {
      switch self {
      case .thin:       return .thin
      case .light:      return .light
      case .regular:    return .regular
      case .medium:     return .medium
      case .semiBold:   return .semibold
      case .bold:       return .bold
      case .heavy:      return .heavy
      }
    }
  }
  
  public static func custom(_ suit: Suit, _ size: CGFloat) -> UIFont {
    return UIFont(name: suit.name, size: size) ?? .systemFont(ofSize: size, weight: suit.type)
  }
}
