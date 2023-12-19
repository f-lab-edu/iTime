//
//  File.swift
//  
//
//  Created by 이상헌 on 12/16/23.
//

import OSLog

extension OSLog {
  private static var subsystem = Bundle.main.bundleIdentifier!
  public static let presenter = OSLog(subsystem: subsystem, category: "Presenter")
  public static let infra = OSLog(subsystem: subsystem, category: "Infra")
  public static let domain = OSLog(subsystem: subsystem, category: "Domain")
}
