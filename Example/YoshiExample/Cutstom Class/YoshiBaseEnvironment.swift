//
//  YoshiBaseEnvironment.swift
//  Yoshi
//
//  Created by Kanglei Fang on 25/09/2017.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Yoshi

/// Default basic implementation of YoshiEnvironment protocol.
internal enum YoshiBaseEnvironment: String, YoshiEnvironment, Codable {
    
    case qa, production
    
    var name: String {
        switch self {
        case .qa:
            return "QA"
        case .production:
            return "Production"
        }
    }
    
    var baseURL: URL {
        switch self {
        case .qa:
            return URL(string: "https://www.qa.com")!
        case .production:
            return URL(string: "https://www.production.com")!
        }
    }
}
