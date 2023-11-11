//
//  DoubleExtension.swift
//  TaxiDispatch
//
//  Created by 이상헌 on 2023/08/09.
//

import Foundation

extension Double {
    
    func meterToString() -> String {
        let metersToInt = Int(self)
        let kilometers = metersToInt / 1000
        let meters = metersToInt % 1000
        
        if kilometers > 0 {
            return "\(kilometers).\(meters)km"
        } else {
            return "\(meters)m"
        }
    }
    
    /// 천단위 개행 처리 (20000 -> 20,000)
    func thousandSeparator() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = ","
        
        return formatter.string(for: self) ?? "thousandSeparator: 변환 실패"
    }
    
}
