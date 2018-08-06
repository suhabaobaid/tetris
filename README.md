## Project
Tetris Game for IOS

## Code style
Swiftlint with custom rules. You can find the rules in .swiftlint.yml where you can modify it to your needs. Checkout SwiftLint
[swiftlint](https://github.com/realm/SwiftLint)

## Tech/framework used
**Built with**
- [Swift](https://developer.apple.com/swift/)
- [ReSwift](https://github.com/ReSwift/ReSwift) For State app management


## Installation
To get the project started: 
- Make sure you have cocoa pods installed (https://cocoapods.org) then install the pods
```shell
pod install
```
- Make sure you have .xcworkspace generated. Open this file instead of .xcodeproj in Xcode always.
- Add Config.xcconfig file in the root directory. Add the following lines. Replace <identifier> with your bundle identifier
```swift
BUNDLE_ID = <identifier>.swiftris
PRODUCT_BUNDLE_IDENTIFIER = <identifier>.swiftris
```
- Run the project by pressing the run button in xcode

## Credits
The original game was developed through a great tutorial link:https://www.bloc.io/swiftris-build-your-first-ios-game-with-swift . Make sure to check the other tutorials
