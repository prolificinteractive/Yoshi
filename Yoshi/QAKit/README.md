# QAKit

QAKit provides menus for some frequently used QA tasks.

## EnvironmentMenu

Environment Menu is used to globally change and store the networking environment (http base URL) of your app. Yoshi leverages the new `JSONDecoder` and `JSONEnCoder` in Swift 4 to help persist the environment selection in `USerDefaults`. So when user selects the menu, the selection is persisted and will be retrieved automatically next time app is opened.

To set it up, just make your environment model adopt `Codable` and `YoshiEnvironment`:

```swift

internal struct YoshiBaseEnvironment: Codable, YoshiEnvironment {
    var name: String
    var baseURL: URL
}

```


Then, provide the environments:

```swift

let environmentOptions = [YoshiBaseEnvironment(name: "Production", baseURL: URL(string: "https://mobile-api.com")!),
YoshiBaseEnvironment(name: "Staging", baseURL: URL(string: "https://staging.mobile-api.com")!),
YoshiBaseEnvironment(name: "QA", baseURL: URL(string: "http://qa.mobile-api.com")!)]

```

Then, register the callback and environments to the environment manager.

```swift

// If you want to get the callback when environment is initialized, register the callback when initializing the manager.
let environmentManager = YoshiEnvironmentManager(environments: environmentOptions) { (environment) in
    /// Do something when environment is changed.
}

// Or, you can register the callback separately.
// Notice that this way callback won't be invoked when environment is retrieved from the archive.
environmentManager.onEnvironmentChange = { (environment) in
    /// Do something when environment is changed.
}

```

Finally, construct the environment menu and setup it up like other Yoshi menus:

```swift

let environmentMenu = YoshiEnvironmentMenu(environmentManager: environmentManager)
Yoshi.setupDebugMenu([environmentMenu, ... // Other menus])

```
