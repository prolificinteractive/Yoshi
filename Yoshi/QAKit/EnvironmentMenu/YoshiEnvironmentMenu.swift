//
//  YoshiEnvironmentMenu.swift
//  Yoshi
//
//  Created by Kanglei Fang on 28/08/2017.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Menu used to present a list of environment options and interact with YoshiEnvironmentManager.
public final class YoshiEnvironmentMenu<T: YoshiEnvironment & Codable>: YoshiSingleSelectionMenu {

    /// Initialize the menu with the title and possible environment options.
    ///
    /// - Parameters:
    ///   - title: Title of the menu, default to "Environment".
    ///   - environmentManager: A YoshiEnvironmentManager that manage environments.
    public init(title: String = "Environment", environmentManager: YoshiEnvironmentManager<T>) {
        super.init(title: title,
                   options: environmentManager.environments.map {
                    YoshiSingleSelection(title: $0.name, subtitle: $0.baseURL.absoluteString)},
                   selectedIndex: environmentManager.environments.enumerated().reduce (0, { origSelection, env in
                    env.element == environmentManager.currentEnvironment ? env.offset : origSelection
                   }),
                   didSelect: { selection in
                    guard let selectedEnvironment = environmentManager.environments.filter ({
                        $0.baseURL.absoluteString == selection.subtitle
                    }).first else {
                        return
                    }
                    environmentManager.currentEnvironment = selectedEnvironment
        })
    }
}
