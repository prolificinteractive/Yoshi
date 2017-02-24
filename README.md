![Yoshi](Images/Yoshi_logo.jpg)

[![Travis build status](https://img.shields.io/travis/prolificinteractive/Yoshi.svg?style=flat-square)](https://travis-ci.org/prolificinteractive/Yoshi)
[![Cocoapods Compatible](https://img.shields.io/cocoapods/v/Yoshi.svg?style=flat-square)](https://img.shields.io/cocoapods/v/Yoshi.svg)
[![Platform](https://img.shields.io/cocoapods/p/Yoshi.svg?style=flat-square)](http://cocoadocs.org/docsets/Yoshi)
[![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat-square)](http://cocoadocs.org/docsets/Yoshi)
[![Docs](https://img.shields.io/cocoapods/metrics/doc-percent/Yoshi.svg?style=flat-square)](http://cocoadocs.org/docsets/Yoshi)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Description

A helpful companion for your iOS app.

Yoshi is a convenient wrapper around the UI code that is often needed for displaying debug menus. Out of the box, Yoshi provides easy-to-implement date, list and custom menus.

### iPhone
![Yoshi.gif](Images/Yoshi.gif)

### iPad
![Yoshi_iPad.gif](Images/Yoshi_iPad.gif)

## Requirements

* iOS 8.0+
* Xcode 8.0+

## Installation

### CocoaPods
Yoshi is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

###### Swift 3.0

```ruby
pod "Yoshi"
```

###### Swift 2.3

```ruby
pod 'Yoshi', '1.1.1'
```

### Carthage
You can also add Yoshi to your project using [Carthage](https://github.com/Carthage/Carthage). Add the following to your `Cartfile`:

```ruby
github "prolificinteractive/Yoshi"
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
let production = MenuItem(name: "Production")
let staging = MenuItem(name: "Staging")
let qa = MenuItem(name: "QA", selected: true)
let environmentItems: [YoshiTableViewMenuItem] = [production, staging, qa]

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
      // Do something with the selected date here
})

Yoshi.setupDebugMenu([dateSelectorMenu])
Yoshi.show()
```

### Custom Menu

Yoshi can also be configured to display custom menus which can be used for triggering events or presenting view controllers.

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

### Invocation Options

Yoshi can be invoked with a number of different options. The simplest way is to manually invoke using the `show()` function.

```swift
Yoshi.show()
```

In addition to the vanilla invocation option, Yoshi can also be invoked in response of 3 different options of motion or touch events.   
If you want to enable all of those 3 following options you can simply pass the `all` option to the `setupDebugMenu`, although this option is already the default one.

```swift
Yoshi.setupDebugMenu([/* YoshiMenu items */], invocations: [.all])
/// Or simply
Yoshi.setupDebugMenu([/* YoshiMenu items */])
```

To specify which option you want exactly you just need to pass the ones you want to the `setupDebugMenu` function like this:

* To invoke Yoshi in response to a shake-motion gesture, add the `shakeMotionGesture` option in the `setupDebugMenu` invocations parameter as follows.

```swift
Yoshi.setupDebugMenu([/* YoshiMenu items */], invocations: [.shakeMotionGesture])
```

* To invoke Yoshi in in response to a multi-touch event, add the `multiTouch` option in the `setupDebugMenu` invocations parameter as follows.

```swift
Yoshi.setupDebugMenu([/* YoshiMenu items */], invocations: [.multiTouch])
```

* Finally, to invoke Yoshi in response to a 3D touch event, add the `forceTouch` option in the `setupDebugMenu` invocations parameter as follows.

```swift
Yoshi.setupDebugMenu([/* YoshiMenu items */], invocations: [.forceTouch])
```

### Extra features

#### Clipboard copy
Long press on any cell of the Yoshi Menu to copy the subtitle.

#### Custom nib support

You can custom Yoshi menu cells using nib file.
To support custom UI, create your own `UITableViewCell` subclass, and provide a `YoshiResuableCellDataSource` instance referencing to your cell.

```swift
private final class CustomMenuCellDataSource: YoshiResuableCellDataSource {

    static var nib: UINib? {
        // Return your Nib file here
        return UINib(nibName: "CustomCell", bundle: nil)
    }

    func cellFor(tableView: UITableView) -> UITableViewCell {
        guard let cell = (tableView.dequeueReusableCell(withIdentifier: CustomMenuCellDataSource.reuseIdentifier) ??
            UITableViewCell(style: .subtitle, reuseIdentifier: CustomMenuCellDataSource.reuseIdentifier)) as? CustomCell else {
                fatalError()
        }
        // config your cell here
        cell.label.text = "This is a custom cell"
        return cell
    }
}
```

Then, provide the menu that conforms to `YoshiGenericMenu` referencing to the data source.

```swift
internal struct MenuWithCustomUI: YoshiGenericMenu {

    var cellSource: YoshiResuableCellDataSource {
        return CustomMenuCellDataSource()
    }

    func execute() -> YoshiActionResult {
        // Do soomething here when the cell is tapped
        return .Handled
    }
}
```

Finally, display this custom menu like a normal menu

```swift
Yoshi.setupDebugMenu([MenuWithCustomUI()])
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
