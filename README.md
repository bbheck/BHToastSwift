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

<img src="https://cloud.githubusercontent.com/assets/2257294/12374113/f796500a-bc78-11e5-93bc-ac886c3d1f66.gif">

### Showing a BHToast

```swift
import BHToast

BHToast(view: view, message: "This is an example message.").show()
```

### Customizing

You can create a `BHToastOptions` instance with this properties:

* The time that `BHToast` stays in `UIView`
```swift
duration: NSTimeInterval
```

* Toast background color
```swift
backgroundColor: UIColor
```

* Border color
```swift
borderColor: UIColor
```

* Border width
```swift
borderWidth: CGFloat
```

* Corner radius
```swift
cornerRadius: CGFloat
```

* The min height
```swift
minHeight: CGFloat
```

* The max height
```swift
maxHeight: CGFloat
```

* The bottom distance
```swift
bottomOffset: CGFloat
```

* The message padding
```swift
messagePadding: CGFloat
```

* The message font
```swift
messageFont: UIFont
```

* The message color
```swift
messageColor: UIColor
```

## Author

Bruno Hecktheuer, bbheck@gmail.com

## License

BHToast is available under the MIT license. See the LICENSE file for more info.
