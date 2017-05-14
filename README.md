# TPSharePlatform

[![CI Status](http://img.shields.io/travis/bygd2014@sina.com/TPSharePlatform.svg?style=flat)](https://travis-ci.org/bygd2014@sina.com/TPSharePlatform)
[![Version](https://img.shields.io/cocoapods/v/TPSharePlatform.svg?style=flat)](http://cocoapods.org/pods/TPSharePlatform)
[![License](https://img.shields.io/cocoapods/l/TPSharePlatform.svg?style=flat)](http://cocoapods.org/pods/TPSharePlatform)
[![Platform](https://img.shields.io/cocoapods/p/TPSharePlatform.svg?style=flat)](http://cocoapods.org/pods/TPSharePlatform)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

TPSharePlatform is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "TPSharePlatform"
```
## Usage

```ruby
    var sharePlatform = new TPSharePlatform();
    sharePlatform.shareTitle = 'shareTitle';
    sharePlatform.shareContent = 'shareContent';
    sharePlatform.platformName = 'wxsession';
    sharePlatform.success = function(data){
            alert('分享成功');
    }
    sharePlatform.error =function(data){
        alert(data);
    }
    sharePlatform.share();
```


## Author

bygd2014@sina.com, bygd2014@sina.com

## License

TPSharePlatform is available under the MIT license. See the LICENSE file for more info.
