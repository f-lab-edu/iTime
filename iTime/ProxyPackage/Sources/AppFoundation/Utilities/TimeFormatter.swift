//
//  TimeFormatter.swift
//  TaxiDispatch
//
//  Created by 이상헌 on 2023/08/07.
//

import Foundation

public final class TimeFormatter: DateFormatter {
  
  public override init() {
    super.init()
    self.timeZone = TimeZone.autoupdatingCurrent
    self.locale = Locale(identifier: "ko_KR")
  }
  
  required public init?(coder aDecoder: NSCoder) {
    assertionFailure("init(coder:) has not been implemented")
    super.init()
  }
  
  public func formatToHHMMSS(date: Date) -> String {
    self.dateFormat = "HH:mm:ss"
    return self.format(date: date)
  }
  
  public func formatToYYYYMMDDHHMM(date: Date) -> String {
    self.dateFormat = "yyyy-MM-dd HH:mm"
    return self.format(date: date)
  }
  
  public func formatToHHMM(date: Date) -> String {
    self.dateFormat = "HH:mm"
    return self.format(date: date)
  }
  
  public func formatToMMDD(date: Date) -> String {
    self.dateFormat = "MM/dd"
    return self.format(date: date)
  }
  // MARK: - priavte method
  
  private func format(date: Date) -> String {
    return self.string(from: date)
  }
  
  private func parse(dateStr: String) -> Date {
    if let v = self.date(from: dateStr) {
      return v
    } else {
      return Date()
    }
  }
  
  private func toDate(timestamp: String) -> Date {
    if let v = Double(timestamp) {
      return Date(timeIntervalSince1970: v)
    } else {
      return Date()
    }
  }
  
}

