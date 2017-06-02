//
//  TACustomTabBarScaleTransform.swift
//  CustomTabBarController
//
//  Created by Apple on 5/26/17.
//  Copyright © 2017 Tarek. All rights reserved.
//

import Foundation
import UIKit
class TACustomTabBarAnimations{
    /**
        This animation consists of scaling down the presenting view and scales up the presented view from the same frame.
     - parameter presenting: The presenting view controller
     - parameter presented: The presented view controller
     - parameter tabBar: the presenting tabBar
     - parameter selectedCell: The selected cell - default : nil
     */
    internal static func scaleTransform(presentingViewController presenting:UIViewController, presentedViewController presented: UIViewController, inTabBar tabBar: TACustomTabBarController, selectedCell: UICollectionViewCell? = nil){
        tabBar.view.isUserInteractionEnabled = false
        presented.view.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        presented.view.alpha = 0
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: UIViewKeyframeAnimationOptions.calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3, animations: {
                presenting.view.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.4, animations: {
                presented.view.alpha = 1
                presenting.view.alpha = 0
            })
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3, animations: {
                presenting.view.transform = CGAffineTransform.identity
                presented.view.transform = CGAffineTransform.identity
            })
        }, completion: { (completed: Bool) in
            
            tabBar.view.isUserInteractionEnabled = true
        })
        
    }
    /**
     This animation consists of scaling down the presenting view and zooming out to see the presented view from the same frame.
     - parameter presenting: The presenting view controller
     - parameter presented: The presented view controller
     - parameter tabBar: the presenting tabBar
     - parameter selectedCell: The selected cell - default : nil
     */

    internal static func scaleDown(presentingViewController presenting:UIViewController, presentedViewController presented: UIViewController, inTabBar tabBar: TACustomTabBarController, selectedCell: UICollectionViewCell? = nil){
        
        tabBar.view.isUserInteractionEnabled = false
        presented.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        presented.view.alpha = 0
        UIView.animate(withDuration: 1, animations: { 
            presenting.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            presenting.view.alpha = 0
            presented.view.transform = CGAffineTransform.identity
            presented.view.alpha = 1
        }) { (completed) in
            presenting.view.transform = CGAffineTransform.identity
            tabBar.view.isUserInteractionEnabled = true
        }
        
    }
    /**
     This animation consists of scaling down the presenting view and zooming in to preview the presented view from the same frame.
     - parameter presenting: The presenting view controller
     - parameter presented: The presented view controller
     - parameter tabBar: the presenting tabBar
     - parameter selectedCell: The selected cell - default : nil
     */

    internal static func scaleUp(presentingViewController presenting:UIViewController, presentedViewController presented: UIViewController, inTabBar tabBar: TACustomTabBarController, selectedCell: UICollectionViewCell? = nil){
        
        tabBar.view.isUserInteractionEnabled = false
        presented.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        presented.view.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            presenting.view.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            presenting.view.alpha = 0
            presented.view.transform = CGAffineTransform.identity
            presented.view.alpha = 1
        }) { (completed) in
            presenting.view.transform = CGAffineTransform.identity
            tabBar.view.isUserInteractionEnabled = true
        }
    }
    
    /**
     This animation consists of scaling down the presenting view and scrol it to the left and scales up the presented view from the same middle of the screen.
     - parameter presenting: The presenting view controller
     - parameter presented: The presented view controller
     - parameter tabBar: the presenting tabBar
     - parameter selectedCell: The selected cell - default : nil
     */
    internal static func scaleOutAndScrollLeft(presentingViewController presenting:UIViewController, presentedViewController presented: UIViewController, inTabBar tabBar: TACustomTabBarController, selectedCell: UICollectionViewCell? = nil){
        
        tabBar.view.isUserInteractionEnabled = false
        presented.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        presented.view.frame.origin.x = -presented.view.frame.width
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3, animations: { 
                presenting.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.4, animations: {
                presented.view.layer.position = tabBar.containerView.center
                presenting.view.frame.origin.x = UIScreen.main.bounds.width
            })
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3, animations: {
                presented.view.transform = CGAffineTransform.identity
                presented.view.frame = tabBar.containerView.frame
            })
        }) { (completion) in
            presenting.view.removeFromSuperview()
            presenting.view.transform = CGAffineTransform.identity
            tabBar.view.isUserInteractionEnabled = true
        }
    }
    
    /**
     This animation consists of scaling down the presenting view and scrol it to the right and scales up the presented view from the same middle of the screen.
     - parameter presenting: The presenting view controller
     - parameter presented: The presented view controller
     - parameter tabBar: the presenting tabBar
     - parameter selectedCell: The selected cell - default : nil
     */
    internal static func scaleOutAndScrollRight(presentingViewController presenting:UIViewController, presentedViewController presented: UIViewController, inTabBar tabBar: TACustomTabBarController, selectedCell: UICollectionViewCell? = nil){
        
        tabBar.view.isUserInteractionEnabled = false
        presented.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        presented.view.frame.origin.x = UIScreen.main.bounds.width
        
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: UIViewKeyframeAnimationOptions.calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3, animations: {
                presenting.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.4, animations: {
                presented.view.layer.position = tabBar.containerView.center
                presenting.view.frame.origin.x = -presenting.view.frame.width
            })
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.3, animations: {
                presented.view.transform = CGAffineTransform.identity
                presented.view.frame = tabBar.containerView.frame
            })
        }) { (completion) in
            presenting.view.removeFromSuperview()
            presenting.view.transform = CGAffineTransform.identity
            tabBar.view.isUserInteractionEnabled = true
        }
    }
//    internal static func scaleTransform(presentingViewController presenting:UIViewController, presentedViewController presented: UIViewController, inTabBar tabBar: TACustomTabBarController, selectedCell: UICollectionViewCell?){

        //Open from bottom
//        guard selectedCell != nil else{
//            return
//        }
//        let collectionViewCellFrameInMainScreen = selectedCell!.convert(selectedCell!.frame, to: UIScreen.main.coordinateSpace)
//        let centerTopPoint = CGPoint(x: collectionViewCellFrameInMainScreen.midX, y: collectionViewCellFrameInMainScreen.origin.y)
//        let initialBezierPath = UIBezierPath(ovalIn: CGRect(origin: centerTopPoint, size: CGSize.zero))
//        let finalBezierPath = UIBezierPath(ovalIn: CGRect(origin: centerTopPoint, size: CGSize(width: UIScreen.main.bounds.height * 4, height: UIScreen.main.bounds.height * 4)))
//        let layer = CAShapeLayer()
//        layer.path = initialBezierPath.cgPath
//        presented.view.layer.mask = layer
//        let animation = CABasicAnimation()
//        animation.keyPath = "path"
//        animation.fromValue = initialBezierPath
//        animation.toValue = finalBezierPath
//        animation.duration = 1
//        animation.isRemovedOnCompletion = false
//        presented.view.layer.mask?.add(animation, forKey: "path")
        
}
