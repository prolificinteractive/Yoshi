//
//  YoshiEncodableEnvironmentManager.swift
//  Yoshi
//
//  Created by Kanglei Fang on 25/09/2017.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Environment selection event.
public typealias EnvironmentChangeEvent<T: YoshiEnvironment & Codable> = (T) -> Void

/// A YoshiEnvironmentManager that persisits user's environment selection using NSUserDefaults.
public class YoshiEnvironmentManager<T: YoshiEnvironment & Codable> {
    
    public var currentEnvironment: T {
        didSet {
            guard !(currentEnvironment == oldValue) else {
                return
            }
            YoshiEnvironmentManager.archive(environment: currentEnvironment)
            onEnvironmentChange?(currentEnvironment)
        }
    }
    
    public private(set) var environments: [T]
    
    /// Callback when new environment is selected.
    public var onEnvironmentChange: EnvironmentChangeEvent<T>?
    
    /// Initialize the environement manager with the given environments.
    /// The manger will retrieve the archived environment selection from NSUserDefaults if any.
    /// Othereise the first environment will be used as the current environment.
    ///
    /// - Parameters:
    ///   - environments: Available Environments.
    ///   - onEnvironmentChange: Callback when environment is changed.
    ///                          Notice that the if set here, callback will be invoked when the manager is initialized.
    public init(environments: [T], onEnvironmentChange: EnvironmentChangeEvent<T>? = nil) {
        self.environments = environments
        self.onEnvironmentChange = onEnvironmentChange
        if let archivedEnvironment = YoshiEnvironmentManager.archivedEnvironment,
            environments.contains(where: { $0 == archivedEnvironment }) {
            currentEnvironment = archivedEnvironment
        } else {
            guard let defaultEnvironment = environments.first else {
                fatalError("YoshiPersistentEnvironmentManager must be initialized with at least one environment")
            }
        
            currentEnvironment = defaultEnvironment
        }
        onEnvironmentChange?(currentEnvironment)
    }
}

private struct Constants {
    static let YoshiEnvironmentKey = "YoshiEnvironment"
    
    static let encoder = JSONEncoder()
    static let decoder = JSONDecoder()
}

private extension YoshiEnvironmentManager {

    class var archivedEnvironment: T? {
        guard let archived = UserDefaults.standard.data(forKey: Constants.YoshiEnvironmentKey),
            let environmentContainer = try? Constants.decoder.decode(YoshiPersistentEnvironment<T>.self, from: archived) else {
                return nil
        }
        return environmentContainer.persistedEnvironment
    }
    
    class func archive(environment: T) {
        let arcivingEnvironmentContainer = YoshiPersistentEnvironment(environment: environment)
        let jsonData = try? Constants.encoder.encode(arcivingEnvironmentContainer)
        UserDefaults.standard.setValue(jsonData, forKey: Constants.YoshiEnvironmentKey)
        UserDefaults.standard.synchronize()
    }
}
