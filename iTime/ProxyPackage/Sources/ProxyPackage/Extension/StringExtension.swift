//
//  StringExtension.swift
//  TaxiDispatch
//
//  Created by 이상헌 on 2023/07/06.
//

import Foundation

extension String {
    var isNotEmpty: Bool {
        !self.isEmpty
    }
    
    var removedPrefixString: String {
        self.replacingOccurrences(of: "현위치: ", with: "")
    }
    
    func search(of target: String) -> Range<Index>? {
        var leftIndex = startIndex
        
        while true {
            guard self[leftIndex] == target[target.startIndex] else {
                leftIndex = index(after:leftIndex)
                if leftIndex >= endIndex { return nil }
                continue
            }
            
            var rightIndex = index(after: leftIndex)
            var targetIndex = target.index(after:target.startIndex)
            
            while self[rightIndex] == target[targetIndex] {
                guard distance(from: leftIndex, to: rightIndex) < target.count - 1 else {
                    return leftIndex..<index(after: rightIndex)
                }
                
                rightIndex = index(after:rightIndex)
                targetIndex = target.index(after: targetIndex)
                
                if rightIndex >= endIndex { return nil }
            }
            
            leftIndex = index(after: leftIndex)
        }
    }
}
 
