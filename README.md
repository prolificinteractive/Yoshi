![Yoshi](yoshi.jpg)

[![Travis build status](https://img.shields.io/travis/prolificinteractive/Yoshi.svg?style=flat-square)](https://travis-ci.org/prolificinteractive/Yoshi)
[![Cocoapods Compatible](https://img.shields.io/cocoapods/v/Yoshi.svg?style=flat-square)](https://img.shields.io/cocoapods/v/Yoshi.svg)
[![Platform](https://img.shields.io/cocoapods/p/Yoshi.svg?style=flat-square)](http://cocoadocs.org/docsets/Yoshi)
[![Docs](https://img.shields.io/cocoapods/metrics/doc-percent/Yoshi.svg?style=flat-square)](http://cocoadocs.org/docsets/Yoshi)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Description

A helpful companion for your iOS app.

Yoshi is a convenient wrapper around the UI code that is often needed for displaying debug menus. Out of the box, Yoshi provides easy-to-implement date, list and custom menus.

## Requirements

* iOS 8.0+
* Xcode 7.2+

## Installation

### CocoaPods
Yoshi is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```ruby
pod "Yoshi"
```

### Carthage
You can also add Yoshi to your project using [Carthage](https://github.com/Carthage/Carthage). Add the following to your `Cartfile`:

```ruby
github "prolificInteractive/Yoshi"
```

## Usage

Yoshi can be set up to display any sort of menu as long as the menu object conforms to `YoshiMenu`. Yoshi comes with two built-in menus: list menu and date menu.

### List Menu

To display a list menu, create two types that conform to `YoshiTableViewMenu` and `YoshiTableViewMenuItem` protocols respectively.

```swift
struct TableViewMenu: YoshiTableViewMenu {

    var title: String
    var subtitle: String?
    var displayItems: [YoshiTableViewMenuItem]
    var didSelectDisplayItem: (displayItem: YoshiTableViewMenuItem) -> ()

}

internal final class MenuItem: YoshiTableViewMenuItem {

    let name: String
    var selected: Bool

    init(name: String,
         selected: Bool = false) {
        self.name = name
        self.selected = selected
    }

}
```

Then, set up the menu and present it using Yoshi.

```swift
let menuItemProd = MenuItem(name: "Production", selected: true)
let menuItemStaging = MenuItem(name: "Staging")
let menuItemQA = MenuItem(name: "QA")
let environmentItems: [YoshiTableViewMenuItem] = [menuItemProd, menuItemStaging, menuItemQA]

let tableViewMenu = TableViewMenu(title: "Environment",
  subtitle: nil,
  displayItems: environmentItems,
  didSelectDisplayItem: { (displayItem) in
    // Switch environment here
})

Yoshi.setupDebugMenu([tableViewMenu])

// Invoke Yoshi
Yoshi.show()
```

Yoshi will take care of managing selections and call back the convenient closure function when a new selection is made.

### Date Selector Menu

Similarly, to present a date selector menu, create a type that conforms to `YoshiDateSelectorMenu` protocol

```swift
internal final class DateSelector: YoshiDateSelectorMenu {

    var title: String
    var subtitle: String?
    var selectedDate: NSDate
    var didUpdateDate: (dateSelected: NSDate) -> ()

    init(title: String,
         subtitle: String? = nil,
         selectedDate: NSDate = NSDate(),
         didUpdateDate: (NSDate) -> ()) {
        self.title = title
        self.subtitle = subtitle
        self.selectedDate = selectedDate
        self.didUpdateDate = didUpdateDate
    }

}
```

and present it using the same functions.

```swift
let dateSelectorMenu = DateSelector(title: "Environment Date",
    subtitle: nil,
    didUpdateDate: { (dateSelected) in
    NSNotificationCenter.defaultCenter()
        .postNotificationName(Notifications.EnvironmentDateUpdatedNotification, object: dateSelected)
})

Yoshi.setupDebugMenu([dateSelectorMenu])
Yoshi.show()
```

### Custom Menu

Yoshi can also be configured to display custom menus which can be used for triggering custom events or presenting custom view controllers.

For example, we can invoke [Instabug](https://instabug.com) when a custom menu is selected.

```swift
private struct CustomMenu: YoshiMenu {

    let title: String
    let subtitle: String?
    let completion: () -> ()

    func execute() -> YoshiActionResult {
        return .AsyncAfterDismissing(completion)
    }

}

Instabug.startWithToken("abcdefghijklmnopqrstuvwxyz", invocationEvent: .None)
Instabug.setDefaultInvocationMode(.BugReporter)

let instabugMenu = CustomMenu(title: "Start Instabug",
    subtitle: nil,
    completion: {
        Instabug.invoke()
    })

Yoshi.setupDebugMenu([instabugMenu])
Yoshi.show()
```

## Contributing to Yoshi

To report a bug or enhancement request, feel free to file an issue under the respective heading.

If you wish to contribute to the project, fork this repo and submit a pull request. Code contributions should follow the standards specified in the [Prolific Swift Style Guide](https://github.com/prolificinteractive/swift-style-guide).

## License

![prolific](https://s3.amazonaws.com/prolificsitestaging/logos/Prolific_Logo_Full_Color.png)

Copyright (c) 2016 Prolific Interactive

Yoshi is maintained and sponsored by Prolific Interactive. It may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: ./LICENSE
