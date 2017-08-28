//
//  YoshiEnvironmentManager.swift
//  Yoshi
//
//  Created by Kanglei Fang on 28/08/2017.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

public protocol YoshiEnvironmentManager: class {
    
    /// The current HTTP environment.
    var currentEnvironment: YoshiEnvironment { get set }
    
    /// All the available HTTP environments.
    var environments: [YoshiEnvironment] { get }
}
