# BHToast

![Swift](https://img.shields.io/badge/language-Swift-orange.svg)
[![CI Status](http://img.shields.io/travis/bbheck/BHToast.svg?style=flat)](https://travis-ci.org/bbheck/BHToast)
[![Version](https://img.shields.io/cocoapods/v/BHToast.svg?style=flat)](http://cocoapods.org/pods/BHToast)
[![License](https://img.shields.io/cocoapods/l/BHToast.svg?style=flat)](http://cocoapods.org/pods/BHToast)
[![Platform](https://img.shields.io/cocoapods/p/BHToast.svg?style=flat)](http://cocoapods.org/pods/BHToast)

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

### Showing a BHToast (only message)

```swift
import BHToast

BHToast(view: view, message: "This is an example message.").show()
```

### Showing a BHToast (with image)

```swift
import BHToast

BHToast(view: view, message: "This is an example message.", imageView: `yourImageView`).show()
```

### Showing a BHToast (with options)

```swift
import BHToast

let options = BHToastOptions(
    duration: 10.0,
    borderWidth: 0.0,
    cornerRadius: 0.0
)

BHToast(view: view, message: "This is an example message.", options: options).show()
```

### Customizing

`BHToastViewTag` is used to guarantee only one instance in view.
If necessary, change it before first BHToast instance.

You can create a `BHToastOptions` instance with this properties:

* The time that `BHToast` stays in `UIView`. *Default: 5.0*
```swift
duration: NSTimeInterval
```

* The animation time (in seconds). *Default: 0.4*
```swift
animationDuration: NSTimeInterval
```

* Toast background color. *Default: UIColor.lightGrayColor()*
```swift
backgroundColor: UIColor
```

* Border color. *Default: UIColor.darkGrayColor()*
```swift
borderColor: UIColor
```

* Border width. *Default: 1.0*
```swift
borderWidth: CGFloat
```

* Corner radius. *Default: 5.0*
```swift
cornerRadius: CGFloat
```

* The bottom distance. *Default: 8.0*
```swift
bottomOffset: CGFloat
```

* The content insets. *Default: UIEdgeInsetsMake(8.0, 8.0, 8.0, 8.0)*
```swift
contentInsets: UIEdgeInsets
```

* The min height. *Default: 30.0*
```swift
minHeight: CGFloat
```

* The max height. *Default: 50.0*
```swift
maxHeight: CGFloat
```

* The message alignment. *Default: NSTextAlignment.Center*
```swift
messageAlignment: NSTextAlignment
```

* The message color. *Default: UIColor.whiteColor()*
```swift
messageColor: UIColor
```

* The message font. *Default: UIFont.systemFontOfSize(14.0)*
```swift
messageFont: UIFont
```

* The image position (if set). *Default: BHToastImagePosition.Left*
```swift
imagePosition: BHToastImagePosition
```

**All this properties have a default value. Change it to apply the customizations to all new `BHToast` instances.**

## Author

Bruno Hecktheuer, bbheck@gmail.com

## License

BHToast is available under the MIT license. See the LICENSE file for more info.
