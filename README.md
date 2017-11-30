# RimhTypingLetters
[![Version](https://img.shields.io/cocoapods/v/RimhTypingLetters.svg?style=flat)](http://cocoapods.org/pods/RimhTypingLetters)
[![License](https://img.shields.io/cocoapods/l/RimhTypingLetters.svg?style=flat)](http://cocoapods.org/pods/RimhTypingLetters)
[![Platform](https://img.shields.io/cocoapods/p/RimhTypingLetters.svg?style=flat)](http://cocoapods.org/pods/RimhTypingLetters)

A simple typing animation for UITextView and UILabel.

## Requirements
XCode 9.1, Swift 4.0, iOS 8 or above

## Demo

Just simply typing text (no-wrapping).

![typing](https://user-images.githubusercontent.com/19208995/33176722-65163b78-d0a3-11e7-898a-3c268e9c70fc.gif)

Typing with word-wrap.

![typing_delimiter](https://user-images.githubusercontent.com/19208995/33176723-654ba966-d0a3-11e7-8c79-ddd1c8633297.gif)

## Installation

RimhTypingLetters is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RimhTypingLetters'
```
## Usage
First, you need to import the module.
```swift
import RimhTypingLetters
```
For TextView:
```swift
@IBOutlet weak var textview:TypingLetterUITextView!
// You can specific delimiter to wrap the content such as a space.
textview.typeText(message, delimiter: " ", typingSpeedPerChar: 0.05, didResetContent: true) {
            // complete action after finished typing
}
// By default: delimiter = nil (no-wrapping), typingSpeedPerChar = 0.04, didResetContent = true.
textview.typeText(message) {
           // complete action after finished typing
}
```
For Label:
```swift
// Extension function in UILabel is similar to TypingLetterUITextView's function, just only delimiter parameter is not exist. 
label.typeText(message, typingSpeedPerChar: 0.1, didResetContent = true, completeCallback:{
           // complete action after finished typing
}
```
If you want to customize the function, you can create a subclass.
```swift
class MyTextView:TypingLetterUITextView {
    override func updateTypingTextView(_ character: Character) {
        super.updateTypingTextView(character)
    }
}
```
## License

RimhTypingLetters is available under the MIT license. See the LICENSE file for more info.
