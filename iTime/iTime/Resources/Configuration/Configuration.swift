//
//  Configuration.swift
//  iTime
//
//  Created by 이상헌 on 11/8/23.
//

import Foundation

struct AppConfiguration {
    static var apiServerURL: String {
        guard let apiServerURL = Bundle.main.object(forInfoDictionaryKey: "ApiServerUrl") as? String else {
            fatalError("API_SERVER_URL could not be found in plist.")
        }
        return apiServerURL
    }

    static var deployPhase: String {
        guard let phase = Bundle.main.object(forInfoDictionaryKey: "DeployPhase") as? String else {
            fatalError("DEPLOY_PHASE could not be found in plist.")
        }
        return phase
    }
}
