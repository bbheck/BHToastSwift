# Change Log

## 0.4.0 (2017-07-09)

### Enhancements

- Add two new positions. Now you can show the `BHToast` on the top, middle or bottom.
- Create a `BHToastUtils` to access the top most view controller.
- Change properties name (`bottomOffset` -> `margin`, `defaultBottomOffset` -> `defaultMargin`).

## 0.3.1 (2016-02-28)

### Enhancements

- Add support to add/change the message and the imageView.
- Create a generic method to manage the `BHToast` constraints.
- Improve some documentation.

### Bug fixed

- Fix when the same `BHToast` instance called more than once the `show` method.


## 0.3.0 (2016-01-17)

### Enhancements

- Add image support in two positions (Left and Right).
- Create enum `BHToastImagePosition`.
- Add `messageAlignment` in `BHToastOptions`.
- Change `messagePadding` to `contentInsets` in `BHToastOptions`.
- Transfer `animationDuration` to `BHToastOptions`.


## 0.2.0 (2016-01-16)

### Enhancements

- Add the parameter options (`BHToastOptions`) in init method to a specific customization.
- Change the way how to customize the `BHToast`. In int method or change the `BHToastOptions` default values.


## 0.1.0 (2016-01-13)

### Enhancements

- Change `height` to `minHeight` and `maxHeight` properties in `BHToastOptions`
- Add constraints to `minHeight` and `maxHeight` in `BHToast`


## 0.1.0 (2016-01-12)

### Enhancements

- Created example project
- Support CocoaPods
