![Yoshi](Images/Yoshi_logo.jpg)

[![Travis build status](https://img.shields.io/travis/prolificinteractive/Yoshi.svg?style=flat-square)](https://travis-ci.org/prolificinteractive/Yoshi)
[![Cocoapods Compatible](https://img.shields.io/cocoapods/v/Yoshi.svg?style=flat-square)](https://img.shields.io/cocoapods/v/Yoshi.svg)
[![Platform](https://img.shields.io/cocoapods/p/Yoshi.svg?style=flat-square)](http://cocoadocs.org/docsets/Yoshi)
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
github "prolificinteractive/Yoshi"
```

## Usage

A common use case for Yoshi would be to present a menu for API environment switching. Yoshi takes care of presenting the UI for environment selection and calls the convenient closure function when a selection is made.

```swift
import Yoshi

let menuItemProd = MenuItem(name: "Production")
let menuItemStaging = MenuItem(name: "Staging")
let environmentItems: [YoshiTableViewMenuItem] = [menuItemProd, menuItemStaging]

let tableViewMenu = TableViewMenu(title: "Environment",
  subtitle: nil,
  displayItems: environmentItems,
  didSelectDisplayItem: { (displayItem) in
    // Switch environment here
})

Yoshi.setupDebugMenu([tableViewMenu])

// Invoke Yoshi
Yoshi.showDebugActionSheet()
```

## Contributing to Yoshi

To report a bug or enhancement request, feel free to file an issue under the respective heading.

If you wish to contribute to the project, fork this repo and submit a pull request. Code contributions should follow the standards specified in the [Prolific Swift Style Guide](https://github.com/prolificinteractive/swift-style-guide).

## License

![prolific](https://s3.amazonaws.com/prolificsitestaging/logos/Prolific_Logo_Full_Color.png)

Copyright (c) 2016 Prolific Interactive

Yoshi is maintained and sponsored by Prolific Interactive. It may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: ./LICENSE
