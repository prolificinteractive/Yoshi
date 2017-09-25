# QAKit

QAKit provides menus for some frequestly used QA tasks.

## EnvironmentMenu

Environment Menu is used to globally change and store the networking environment (http base URL) of your app. To set it up, just provide the environments:

```swift

let environmentOptions = [YoshiEnvironment(name: "Production", baseURL: URL(string: "https://mobile-api.com")!),
YoshiEnvironment(name: "Staging", baseURL: URL(string: "https://staging.mobile-api.com")!),
YoshiEnvironment(name: "QA", baseURL: URL(string: "http://qa.mobile-api.com")!)]

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
