# CloudTagView

[![Version](https://img.shields.io/cocoapods/v/CloudTagView.svg?style=flat)](http://cocoapods.org/pods/CloudTagView)
[![License](https://img.shields.io/cocoapods/l/CloudTagView.svg?style=flat)](http://cocoapods.org/pods/CloudTagView)
[![Platform](https://img.shields.io/cocoapods/p/CloudTagView.svg?style=flat)](http://cocoapods.org/pods/CloudTagView)

This Pod helps you to create a simple cloud of tags based on Strings. You can manipulate the text, the padding and you can use the tintColor to modify the tag color. There are two delegates to handle taps in the tag: close icon and tag touch. You can access the example project for more details or contacting me.

## Requirements

It requires Xcode 7.0+ and Swift 2.0.

Your project deployment target must be `iOS 8.0+`

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

CloudTagView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CloudTagView"
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

        cloudView.frame = CGRectMake(0, 20, view.frame.width, 10)
        view.addSubview(cloudView)

        addingTags()
    }

    func addingTags() {
        let normalTags = ["This", "is", "a", "example", "of", "Cloud", "Tag", "View"]

        for s in normalTags {
            cloudView.tags.append(TagView(text: s))
        }
    }
}
```

<p align="center"><img src ="https://github.com/Morbix/CloudTagView/raw/master/Screenshot3.png" /></p>

## Author

Henrique Morbin, morbin_@hotmail.com

## License

CloudTagView is available under the MIT license. See the LICENSE file for more info.
