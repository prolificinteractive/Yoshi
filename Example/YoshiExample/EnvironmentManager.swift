//
//  EnvironmentManager.swift
//  YoshiExample
//
//  Created by Kanglei Fang on 29/08/2017.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Yoshi

internal struct Environment: YoshiEnvironment {
    
    let name: String
    
    let baseURL: URL
}

internal final class EnvironmentManager: YoshiEnvironmentManager {
    
    private let environmentOptions = [Environment(name: "Production", baseURL: URL(string: "https://mobile-api.com")!),
                                      Environment(name: "Staging", baseURL: URL(string: "https://staging.mobile-api.com")!),
                                      Environment(name: "QA", baseURL: URL(string: "http://qa.mobile-api.com")!)]

    var currentEnvironment: YoshiEnvironment {
        didSet {
            NotificationCenter.default.post(name:
                NSNotification.Name(rawValue:
                    Notifications.EnvironmentUpdatedNotification),
                                            object: currentEnvironment.name)
        }
    }
    
    var environments: [YoshiEnvironment] {
        return environmentOptions
    }
    
    init() {
        currentEnvironment = environmentOptions.first!
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
