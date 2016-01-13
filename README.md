# BHToast

![Swift](https://img.shields.io/badge/language-Swift-orange.svg)
[![CI Status](http://img.shields.io/travis/bbheck/BHToast.svg?style=flat)](https://travis-ci.org/bbheck/BHToast)
[![Version](https://img.shields.io/cocoapods/v/BHToast.svg?style=flat)](http://cocoapods.org/pods/BHToast)
[![License](https://img.shields.io/cocoapods/l/BHToast.svg?style=flat)](http://cocoapods.org/pods/BHToast)
[![Platform](https://img.shields.io/cocoapods/p/BHToast.svg?style=flat)](http://cocoapods.org/pods/BHToast)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 8.0+
- Xcode 7.0+

## Installation

BHToast is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "BHToast"
```

## Usage

### Showing a BHToast

```swift
import BHToast

BHToast(view: view, message: "This is an example message.").show()
```

### Customizing

```swift
import BHToast

BHToastOptions.duration = 10.0
BHToastOptions.backgroundColor = UIColor.whiteColor()
BHToastOptions.messageColor = UIColor.blackColor()
```

## Author

Bruno Hecktheuer, bbheck@gmail.com

## License

BHToast is available under the MIT license. See the LICENSE file for more info.
