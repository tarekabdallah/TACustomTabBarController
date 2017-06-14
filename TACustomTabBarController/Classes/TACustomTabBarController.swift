//
//  TACustomTabBarController.swift
//  CustomTabBarController
//
//  Created by Apple on 5/19/17.
//  Copyright © 2017 Tarek. All rights reserved.
//

import UIKit
import ObjectiveC
/**
 This is the Controller Delegate. It should be implemented in order to set the position of the text with respect to the image.
 */
@objc public protocol TACustomTabBarControllerDelegate {
    /// decide where to display the text in the collection view. Default: belowImage
    @objc optional func setTextPositionWithRespectToImage(tabBar: TACustomTabBarController,atIndex itemIndex: Int) -> ItemTextPosition
    /// set the Background color of Item at index. Default: groupTableViewBackground
    @objc optional func setItemBackgroundColor(tabBar: TACustomTabBarController,atIndex itemIndex: Int) -> UIColor
    /// set the text color of Item at index.
    @objc optional func setItemTextColor(tabBar: TACustomTabBarController,atIndex itemIndex: Int) -> UIColor
    /// set the selected item text color of Item at index.
    @objc optional func setSelectedItemColor(tabBar: TACustomTabBarController,atIndex itemIndex: Int) -> UIColor
    /// set the item text color of Item at index.
    @objc optional func setItemTextFont(tabBar: TACustomTabBarController,atIndex itemIndex: Int) -> UIFont
    /// set the color of the seperator. Default: White
    @objc optional func seperatorColor(tabBar: TACustomTabBarController) -> UIColor
    ///set the tabBar Height. Default: 49
    @objc optional func tabBarHeight(tabBar: TACustomTabBarController) -> CGFloat
    ///set ContainerView Background image to view it animations
    @objc optional func containerViewBackgoundImage(tabBar: TACustomTabBarController) -> UIImage
    ///set ContainerView Background color to view it animations
    @objc optional func containerViewBackgoundColor(tabBar: TACustomTabBarController) -> UIColor
    ///set animation used while changing from viewcontroller to another. Default: .none
    @objc optional func animationType(tabBar: TACustomTabBarController) -> AnimationType
}
/**
 Animation used while changing from viewcontroller to another.
 
 - none: No animation
 - scaleTransform: This animation consists of scaling down the presenting view and scales up the presented view from the same frame.
 - scaleDown: This animation consists of scaling down the presenting view and zooming out to see the presented view from the same frame.
 - scaleUp: This animation consists of scaling down the presenting view and zooming in to preview the presented view from the same frame.
 - scaleOutAndScroll: This animation consists of scaling down the presenting view and scrol it.
 */

@objc public enum AnimationType: Int{
    case none = 0, scaleTransform = 1, scaleDown = 2, scaleUp = 3, scaleOutAndScroll = 4
}
/**
 TACustomTabBarController can be used insead of the default tab bar contoller. It has some additional features such as text position with respect to the icon, rach tabBar item Background color, text color
 and text color. seperator color and tab bar height.
 This custom tab bar also enables adding a starting view controller which is not in the tab bar and allows jumping to it at anytime while handling selection.
 */
open class TACustomTabBarController: UIViewController {
    ///Container view were all the view controllers will be displayed. Get only
    public internal(set) var containerView = UIView(frame: .zero)
    ///Array of view controllers. Get only
    public internal(set) var viewControllers:[UIViewController]!
    ///The starting view controller. Get only
    public internal(set) var startingViewController:UIViewController!
    ///IndexPath of the current selected item. Get only
    ///The value is nil if the starting view controller is set and is currently shown
    public internal(set) var selectedIndexPath:IndexPath?
    ///The tab Bar collection view. Get Only
    public internal(set) var tabBar: UICollectionView!
    /// Animation used on presentation
    public internal(set) var preferredAnimation: AnimationType = .none
    
    public var delegate: TACustomTabBarControllerDelegate?
    ///Height of the tabBar. Set and Get available
    public var tabBarHeight: CGFloat!
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.insertSubview(containerView, at: 0)
        tabBarHeight = delegate?.tabBarHeight?(tabBar: self) ?? 49
        setTabBar()
        setTabBarConstraints()
        setContainerView()
        self.addChildViewControllers()
        tabBar.register(TACustomCollectionViewCell.self, forCellWithReuseIdentifier: "tabBarItem")
        preferredAnimation = delegate?.animationType?(tabBar: self) ?? .none
        // Do any additional setup after loading the view.
    }
    override open func viewWillAppear(_ animated: Bool) {
        if startingViewController == nil{
            selectedIndexPath = IndexPath(item: 0, section: 0)
            tabBar.delegate?.collectionView!(tabBar, didSelectItemAt: selectedIndexPath!)
            tabBar.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .top)
            startingViewController = viewControllers.first
        }
    }
    private func addChildViewControllers(){
        for viewController in viewControllers{
            self.addChildViewController(viewController)
            viewController.view.frame = containerView.bounds
            viewController.CustomTabController = self
        }
    }
    /**
     set the stab Bar and add it to the main view
     */
    private func setTabBar(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.minimumLineSpacing = 1
        flowLayout.sectionInset = .zero
        flowLayout.scrollDirection = .horizontal
        let size = CGSize(width: UIScreen.main.bounds.width, height: tabBarHeight)
        tabBar = UICollectionView(frame: CGRect(origin: .zero, size: size), collectionViewLayout: flowLayout)
        tabBar.backgroundColor = .white
        self.giveTabBarEffect(view: tabBar)
        self.view.addSubview(tabBar)
        //        self.tabBar.isScrollEnabled = false
        tabBar.backgroundColor = delegate?.seperatorColor?(tabBar: self) ?? .white
    }
    /**
     add the constraints of the tabBar
     */
    private func setTabBarConstraints(){
        tabBar.heightAnchor.constraint(equalToConstant: tabBarHeight).isActive = true
        tabBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tabBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tabBar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tabBar.delegate = self
        tabBar.dataSource = self
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        
    }
    /**
     add the constraints of the containerView
     */
    private func setContainerView(){
        containerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        containerView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.tabBar.topAnchor).isActive = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = delegate?.containerViewBackgoundColor?(tabBar: self) ?? .black
        if let image = delegate?.containerViewBackgoundImage?(tabBar: self){
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = image
            backgroundImage.contentMode = .scaleAspectFill
            self.containerView.backgroundColor = .clear
            self.view.insertSubview(backgroundImage, at: 0)
        }

    }
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /**
     this function gives the tabBar Effect
     */
    private func giveTabBarEffect(view: UIView){
        view.clipsToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: CGFloat(-1) / UIScreen.main.scale)
        view.layer.shadowRadius = 0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.4
        
    }
    /**
     set the View Controllers to be added to the tabBar Controller and shown in the tabBar
     - parameter viewControllers: List of view controllers to be shown in the tabBar
     */
    public func setViewControllers(viewControllers: [UIViewController]){
        self.viewControllers = viewControllers
    }
    
    /**
     set starting view controller. if not implemnted, view controller at first index will be taken.
     - parameter viewController: view controller shown at the begining and not added to the tabBar
     */
    public func setStartingViewController(viewController: UIViewController){
        startingViewController = viewController
        self.addChildViewController(viewController)
        viewController.view.frame = containerView.bounds
        viewController.CustomTabController = self
        containerView.addSubview(viewController.view)
    }
    /**
     display the starting view controller on the screen
     */
    public func jumpToStartingViewController(){
        if selectedIndexPath != nil{
            tabBar.deselectItem(at: selectedIndexPath!, animated: true)
            selectedIndexPath = nil
        }
        for (index, viewController) in viewControllers.enumerated(){
            if viewController == startingViewController{
                tabBar.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .top)
                break
            }
        }
        if selectedIndexPath == nil{
            startingViewController.view.frame = containerView.bounds
            containerView.addSubview(startingViewController.view)
        }
    }
    /**
     Select any item at a specific index
     - parameter index: the index of the view controller
     */
    public func selectItem(atIndex index: Int){
        if index < viewControllers.count && index >= 0{
            tabBar.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .top)
        }else{
            print("The slected index is outside the allowed range. index: \(index)")
        }
    }
    
}
extension TACustomTabBarController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabBarItem", for: indexPath) as! TACustomCollectionViewCell
        cell.backgroundColor = delegate?.setItemBackgroundColor?(tabBar: self, atIndex: indexPath.item) ?? .groupTableViewBackground
        cell.inactiveColor = delegate?.setItemTextColor?(tabBar: self, atIndex: indexPath.item) ?? .gray
        cell.selectedColor = delegate?.setSelectedItemColor?(tabBar: self, atIndex: indexPath.item) ?? .blue
        cell.titleTextPosition = delegate?.setTextPositionWithRespectToImage?(tabBar: self, atIndex: indexPath.item) ?? .belowImage
        if let textFont = delegate?.setItemTextFont?(tabBar: self, atIndex: indexPath.item){
            cell.titleLabel.font = textFont
        }
        else{
            cell.titleLabel.font = cell.titleLabel.font.withSize(12)
        }
        let viewTabBarItem = viewControllers[indexPath.item].tabBarItem
        if viewTabBarItem != nil{
            cell.titleLabel.text = viewTabBarItem!.title
            cell.titleImageView.image = viewTabBarItem!.image
            cell.inactiveImage = viewTabBarItem!.image
            cell.selectedImage = viewTabBarItem!.selectedImage
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if viewControllers.count <= 5{
            return CGSize(width: (UIScreen.main.bounds.width/CGFloat(viewControllers.count) - 1), height: collectionView.frame.height)
        }
        return CGSize(width: (collectionView.frame.width/5) - 1, height: collectionView.frame.height)
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPath == nil{
            startingViewController.view.removeFromSuperview()
        }
        let viewController = viewControllers[indexPath.item]
        containerView.addSubview(viewController.view)
        viewController.view.frame = containerView.bounds
        viewController.didMove(toParentViewController: self)
        if startingViewController != nil && indexPath != selectedIndexPath{
            let selectedCell = collectionView.cellForItem(at: indexPath)
            switch preferredAnimation {
            case .scaleDown:
                TACustomTabBarAnimations.scaleDown(presentingViewController: viewControllers[selectedIndexPath!.item], presentedViewController: viewController, inTabBar: self, selectedCell: selectedCell)
                break
            case .scaleUp:
                TACustomTabBarAnimations.scaleUp(presentingViewController: viewControllers[selectedIndexPath!.item], presentedViewController: viewController, inTabBar: self, selectedCell: selectedCell)
                break
            case .scaleTransform:
                TACustomTabBarAnimations.scaleTransform(presentingViewController: viewControllers[selectedIndexPath!.item], presentedViewController: viewController, inTabBar: self, selectedCell: selectedCell)
                break
            case .scaleOutAndScroll:
                if indexPath.row > selectedIndexPath!.row{
                    TACustomTabBarAnimations.scaleOutAndScrollRight(presentingViewController: viewControllers[selectedIndexPath!.item], presentedViewController: viewController, inTabBar: self, selectedCell: selectedCell)
                }
                else{
                    TACustomTabBarAnimations.scaleOutAndScrollLeft(presentingViewController: viewControllers[selectedIndexPath!.item], presentedViewController: viewController, inTabBar: self, selectedCell: selectedCell)
                }
                break
            default:
                break
            }
        }
        selectedIndexPath = indexPath
        
    }
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    }
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
}
var customViewController:UIViewController?
extension UIViewController{
    public var CustomTabController:TACustomTabBarController?{
        set{
            var tabBarController : UIViewController? = nil
            if let value = newValue
            {
                tabBarController = value
            }
            objc_setAssociatedObject(self, &customViewController, tabBarController, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
        get{
            return objc_getAssociatedObject(self, &customViewController) as? TACustomTabBarController
        }
    }
}
