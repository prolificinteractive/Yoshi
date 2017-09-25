//
//  YoshiEncodableEnvironmentManager.swift
//  Yoshi
//
//  Created by Kanglei Fang on 25/09/2017.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Environment selection event.
public typealias EnvironmentChangeEvent = (Environment) -> Void

/// A YoshiEnvironmentManager that persisit user's environment selection using NSUserDefaults.
open class YoshiEncodableEnvironmentManager: YoshiEnvironmentManager {
    
    public var currentEnvironment: Environment {
        didSet {
            archive(environment: currentEnvironment)
            onEnvironmentChange?(currentEnvironment)
        }
    }
    
    public private(set) var environments: [Environment]
    
    private static let YoshiEnvironemntKey = "YoshiEnvironment"
    
    private static let encoder = JSONEncoder()
    private static let decoder = JSONDecoder()
    
    private var onEnvironmentChange: EnvironmentChangeEvent?
    
    /// Initialize the environement manager with the given environments.
    /// The manger will retrieve the archaved environment selection from NSUserDefaults if any.
    /// Othereise the first environment will be used as the current environment.
    ///
    /// - Parameters:
    ///   - environments: Available Environments.
    ///   - onEnvironmentChange: Callback when environment is changed.
    ///                          Notice that the callback will be invoked when the manager is initialized.
    public init(environments: [Environment], onEnvironmentChange: EnvironmentChangeEvent?) {
        self.environments = environments
        self.onEnvironmentChange = onEnvironmentChange
        if let archivedEnvironment = YoshiEncodableEnvironmentManager.archivedEnvironment {
            currentEnvironment = archivedEnvironment
        } else {
            let defaultEnvironment = environments[0]
            currentEnvironment = defaultEnvironment
            onEnvironmentChange?(currentEnvironment)
        }
    }
}

private extension YoshiEncodableEnvironmentManager {
    
    class var archivedEnvironment: Environment? {
        guard let archived = UserDefaults.standard.data(forKey: YoshiEnvironemntKey),
            let environment = try? decoder.decode(YoshiEncodableEnvironment.self, from: archived) else {
            return nil
        }
        return environment
    }
    
    func archive(environment: Environment) {
        let encodableEnvironment = YoshiEncodableEnvironment(environment: currentEnvironment)
        let jsonData = try? YoshiEncodableEnvironmentManager.encoder.encode(encodableEnvironment)
        UserDefaults.standard.setValue(jsonData, forKey: YoshiEncodableEnvironmentManager.YoshiEnvironemntKey)
        UserDefaults.standard.synchronize()
    }
}
