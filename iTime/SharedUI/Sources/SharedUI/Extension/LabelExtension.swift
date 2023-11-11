//
//  LabelExtension.swift
//  TaxiDispatch
//
//  Created by 이상헌 on 2023/08/18.
//

import UIKit

import AppFoundation

extension UILabel {
    func applyAttributedString(totalText: String, keyword: String, font: UIFont) {
        let attributedString = NSMutableAttributedString(string: totalText).apply(word: keyword, attrs:[.foregroundColor: UIColor.blue, .font: font])
        self.attributedText = attributedString
    }
    
    func setLineSpacing(kernValue: Double = 0.0,
                        lineSpacing: CGFloat = 0.0,
                        lineHeightMultiple: CGFloat = 0.0) {
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString: NSMutableAttributedString
        if let labelAttributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelAttributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.kern,
                                      value: kernValue,
                                      range: NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}

