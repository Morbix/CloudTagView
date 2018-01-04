# CloudTagView

[![Version](https://img.shields.io/cocoapods/v/CloudTagView.svg?style=flat)](http://cocoapods.org/pods/CloudTagView)
[![License](https://img.shields.io/cocoapods/l/CloudTagView.svg?style=flat)](http://cocoapods.org/pods/CloudTagView)
[![Platform](https://img.shields.io/cocoapods/p/CloudTagView.svg?style=flat)](http://cocoapods.org/pods/CloudTagView)
[![Swift 4.0 compatible](https://img.shields.io/badge/Swift_3.0-compatible-4BC51D.svg?style=flat)](https://developer.apple.com/swift)

This Pod helps you to create a simple cloud of tags based on Strings. You can manipulate the text, the padding and you can use the tintColor to modify the tag color. There are two delegates to handle taps in the tag: close icon and tag touch. You can access the example project for more details or contacting me.

## Requirements

It requires Xcode 9.0+ and Swift 4.0.

Your project deployment target must be `iOS 8.0+`

For Swift 2.x support, use version `1.1.0`
For Swift 3.x support, use version `2.0.0`

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

CloudTagView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CloudTagView'
```

## Usage

### Basic Usage
Just `import CloudTagView` and create a instance of `CloudTagView`. **Works with Storyboard too**

And append instancies of `TagView` inside the cloud.

```swift
import CloudTagView

class ViewController: UIViewController {

    let cloudView = CloudTagView()

    override func viewDidLoad() {
        super.viewDidLoad()

        cloudView.frame = CGRect(x: 0, y: 20, width: view.frame.width, height: 10)
        view.addSubview(cloudView)

        setupTags()
    }

    fileprivate func setupTags() {
        let tags = ["This", "is", "a", "example", "of", "Cloud", "Tag", "View"]

        for tag in tags {
            cloudView.tags.append(TagView(text: tag))
        }
    }
}
```

<p align="center"><img src ="https://github.com/Morbix/CloudTagView/raw/master/Screenshot3.png" /></p>

## Other tags

##### Normal
```swift
let normalTag = TagView(text: "normal tag")
```

##### Fat
```swift
let fatTag = TagView(text: "fat tag")
fatTag.marginTop = 20
```

##### Long
```swift
let longTag = TagView(text: "stretched tag")
longTag.marginLeft = 40
```

#####  Trimmed
```swift
let trimmedTag = TagView(text: "Trimmed: This tag is a example of tag with a huge text.")
trimmedTag.maxLength = 15
```

##### Without Icon
```swift
let withoutIconTag = TagView(text: "tag without dismiss icon")
withoutIconTag.iconImage = nil
```

##### Custom Font
```swift
let customFontTag = TagView(text: "different font tag")
customFontTag.font = UIFont(name: "Baskerville", size: 12)!
```

##### Custom Background Color
```swift
let coloredTag = TagView(text: "colored tag")
coloredTag.backgroundColor = UIColor.blue.withAlphaComponent(0.6)
```

##### Custom Tint Color
```swift
let tintColorTag = TagView(text: "tint color tag")
tintColorTag.tintColor = UIColor.yellow
```

## TagViewDelegate

##### Dismiss Event
```swift
func tagDismissed(_ tag: TagView)
```

##### Touch Event
```swift
func tagTouched(_ tag: TagView)
```

## Author

Henrique Morbin, morbin_@hotmail.com

## License

CloudTagView is available under the MIT license. See the LICENSE file for more info.
