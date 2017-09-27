# QAKit

QAKit provides menus for some frequestly used QA tasks.

## EnvironmentMenu

Environment Menu is used to globally change and store the networking environment (http base URL) of your app. Yoshi leverages the new `JSONDecoder` and `JSONEnCoder` in Swift 4 to help persist the environment selection in `NSUSerDefaults`. So when user selects the menu, the selection is persisted and will be retrieved automatically next time app is opened.

To set it up, just make your environment model adopt `Codable` and `YoshiEnvironment`:

```swift

internal struct YoshiBaseEnvironment: Codable, YoshiEnvironment {
    var name: String
    var basedURL: URL
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

let environmentManager = YoshiEncodableEnvironmentManager(environments: environmentOptions) { (environment) in
    /// Do something when environment is changed.
}

```

Finally, construct the environment menu and setup it up like other Yoshi menus:

```swift

let environmentMenu = YoshiEnvironmentMenu(environmentManager: environmentManager)
Yoshi.setupDebugMenu([environmentMenu, ... // Other menus])

```
