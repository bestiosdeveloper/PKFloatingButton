# PKFloatingButton

[![CocoaPods](https://img.shields.io/cocoapods/p/FaveButton.svg)](https://cocoapods.org/pods/PKFloatingButton)
[![codebeat badge](https://codebeat.co/badges/580517f8-efc8-4d20-89aa-900531610144)](https://codebeat.co/projects/github-com-kumarpramod017-pkfloatingbutton-master)

Floating button that will float over the window or specified view


![preview](https://github.com/kumarpramod017/PKFloatingButton/blob/master/PKFloatingButton.gif)


## Requirements

- iOS 8.0+
- Xcode 9.2

## Installation

For manual instalation, drag Source folder into your project.

os use [CocoaPod](https://cocoapods.org) adding this line to you `Podfile`:

```ruby
pod 'PKFloatingButton'
```

## Usage

#### For Enable Floating

1) Just call `enableFloating()` method with `shared` instance of `PKFloatingButton`

Example:

```swift
PKFloatingButton.shared.enableFloating(onView: self.view, viewToExpand: nil, withImage: #imageLiteral(resourceName: "help_white"), onTapHandler: nil)
```


#### For Disable Floating

1) Just call `disableFloating()` method with `shared` instance of `PKFloatingButton`

Example:

```swift
PKFloatingButton.shared.disableFloating()
```

## Licence

PKFloatingButton is released under the MIT license.











