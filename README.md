# TACustomTabBarController

[![CI Status](http://img.shields.io/travis/Tarek/TACustomTabBarController.svg?style=flat)](https://travis-ci.org/Tarek/TACustomTabBarController)
[![Version](https://img.shields.io/cocoapods/v/TACustomTabBarController.svg?style=flat)](http://cocoapods.org/pods/TACustomTabBarController)
[![License](https://img.shields.io/cocoapods/l/TACustomTabBarController.svg?style=flat)](http://cocoapods.org/pods/TACustomTabBarController)
[![Platform](https://img.shields.io/cocoapods/p/TACustomTabBarController.svg?style=flat)](http://cocoapods.org/pods/TACustomTabBarController)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

TACustomTabBarController is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "TACustomTabBarController"
```
### Add TACustomTabBarController
```ruby
let customTabBarController = TACustomTabBarController() 
```
Create the Tab view controller instance.

### Set the starting View controller
```ruby
customTabBarController.setStartingViewController(viewController: <ViewController>)
```
Set the first view controller to be shownif it is not a part of the tab bar items

### Set the setView controllers
```ruby
customTabBarController.setViewControllers(viewControllers: [<ViewController>,<ViewController>])
```
Set the View controllers that will be shown in the tabBar
### Set the delegate
```ruby
customTabBarController.delegate = self

```
Set the Delegate to access the delegate functions provided

### Jump to starting View controller
```ruby
self.CustomTabController?.jumpToStartingViewController()

```
Insert if you wish to go back to the starting page add the following code in the view controller class a

### Select view controller at index
```ruby
self.CustomTabController?.selectItem(atIndex: <index>)

```
Select Tab Bar item at a specific index
## Author

Tarek, tarek.abdallah@lau.edu

## License

TACustomTabBarController is available under the MIT license. See the LICENSE file for more info.
