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

## Screenshots and App demo
![simulator screen shot - iphone 7 - 2018-08-06 at 23 02 00](https://user-images.githubusercontent.com/13656710/43725035-07dba2a0-99ce-11e8-981d-b6ab6342f1e8.png)

![simulator screen shot - iphone 7 - 2018-08-06 at 23 02 05](https://user-images.githubusercontent.com/13656710/43725050-13bc54b6-99ce-11e8-96ea-fd42982e95a8.png)

![ezgif com-gif-maker](https://user-images.githubusercontent.com/13656710/43724908-c24f9c46-99cd-11e8-9c31-6f084d421633.gif)
