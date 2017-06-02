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

```swift
pod "TACustomTabBarController"
```
### Add TACustomTabBarController
```swift
let customTabBarController = TACustomTabBarController() 
```
Create the Tab view controller instance.

### Set the starting View controller
```swift
customTabBarController.setStartingViewController(viewController: <ViewController>)
```
Set the first view controller to be shownif it is not a part of the tab bar items

### Set the setView controllers
```swift
customTabBarController.setViewControllers(viewControllers: [<ViewController>,<ViewController>])
```
Set the View controllers that will be shown in the tabBar
### Set the delegate
```swift
customTabBarController.delegate = self

```
Set the Delegate to access the delegate functions provided

### Jump to starting View controller
```swift
self.CustomTabController?.jumpToStartingViewController()
```
Insert if you wish to go back to the starting page add the following code in the view controller class a

### Select view controller at index
```swift
self.CustomTabController?.selectItem(atIndex: <index>)
```
Select Tab Bar item at a specific index

##ScaleTransform animation
This animation consists of scaling down the presenting view and scales up the presented view from the same frame.
you can set the animation using the delegate.
<img src ='https://github.com/tarekabdallah/TACustomTabBarController/blob/master/resources/ScaleTransform.gif'
alt="ScaleTransform animation" width='450'>

###ScaleOutAndTransform animation
This animation consists of scaling down the presenting view and scrol it.
you can set the animation using the delegate.
<img src =''
alt="ScaleTransform animation" width='450'>

###ScaleUp animation
This animation consists of scaling down the presenting view and zooming in to preview the presented view from the same frame.
you can set the animation using the delegate.
<img src =''
alt="ScaleTransform animation" width='450'>

###ScaleDown animation
This animation consists of scaling down the presenting view and zooming out to see the presented view from the same frame.
you can set the animation using the delegate.
<img src =''
alt="ScaleTransform animation" width='450'>

###View Documentation on:

## Author

Tarek, tarek.abdallah@lau.edu

## License

TACustomTabBarController is available under the Apache license. See the LICENSE file for more info.
