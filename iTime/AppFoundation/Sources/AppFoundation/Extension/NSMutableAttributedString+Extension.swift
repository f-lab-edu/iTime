//
//  NSMutableAttributedString+Extension.swift
//  omos
//
//  Created by sangheon on 2023/06/10.
//

import UIKit

extension NSMutableAttributedString {
    public func apply(word: String, attrs: [NSAttributedString.Key: Any]) -> NSMutableAttributedString {
        let range = (self.string as NSString).range(of: word)
        return apply(word: word, attrs: attrs, range: range, last: range)
    }
    
    private func apply(word: String, attrs: [NSAttributedString.Key: Any], range: NSRange, last: NSRange) -> NSMutableAttributedString {
        if range.location != NSNotFound {
            self.addAttributes(attrs, range: range)
            let start = last.location + last.length
            let end = self.string.count - start
            let stringRange = NSRange(location: start, length: end)
            let newRange = (self.string as NSString).range(of: word, options: [], range: stringRange)
            _ = apply(word: word, attrs: attrs, range: newRange, last: range)
        }
        return self
    }
    
}

