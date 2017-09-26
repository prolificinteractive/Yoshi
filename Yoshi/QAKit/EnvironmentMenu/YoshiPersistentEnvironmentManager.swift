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

private let YoshiEnvironemntKey = "YoshiEnvironment"

private let encoder = JSONEncoder()
private let decoder = JSONDecoder()

/// A YoshiEnvironmentManager that persisit user's environment selection using NSUserDefaults.
open class YoshiPersistentEnvironmentManager<T: YoshiEnvironment & Codable> {
    
    public var currentEnvironment: T {
        didSet {
            archive(environment: currentEnvironment)
            onEnvironmentChange?(currentEnvironment)
        }
    }
    
    public private(set) var environments: [T]
    
    private var onEnvironmentChange: EnvironmentChangeEvent<T>?
    
    /// Initialize the environement manager with the given environments.
    /// The manger will retrieve the archived environment selection from NSUserDefaults if any.
    /// Othereise the first environment will be used as the current environment.
    ///
    /// - Parameters:
    ///   - environments: Available Environments.
    ///   - onEnvironmentChange: Callback when environment is changed.
    ///                          Notice that the callback will be invoked when the manager is initialized.
    public init(environments: [T], onEnvironmentChange: EnvironmentChangeEvent<T>?) {
        self.environments = environments
        self.onEnvironmentChange = onEnvironmentChange
        if let archivedEnvironment = YoshiPersistentEnvironmentManager.archivedEnvironment,
            environments.contains(where: { $0 == archivedEnvironment }) {
            currentEnvironment = archivedEnvironment
        } else {
            guard let defaultEnvironment = environments.first else {
                fatalError("YoshiPersistentEnvironmentManager must be initalized with at least one environment")
            }
        
            currentEnvironment = defaultEnvironment
        }
        onEnvironmentChange?(currentEnvironment)
    }
}

private extension YoshiPersistentEnvironmentManager {
    
    class var archivedEnvironment: T? {
        guard let archived = UserDefaults.standard.data(forKey: YoshiEnvironemntKey),
            let environment = try? decoder.decode(T.self, from: archived) else {
            return nil
        }
        return environment
    }
    
    func archive(environment: T) {
        let jsonData = try? encoder.encode(environment)
        UserDefaults.standard.setValue(jsonData, forKey: YoshiEnvironemntKey)
        UserDefaults.standard.synchronize()
    }
}
