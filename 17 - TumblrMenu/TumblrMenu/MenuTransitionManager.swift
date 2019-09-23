//
//  MenuTransitionManager.swift
//  TumblrMenu
//
//  Created by Shuai Hao on 2019/9/23.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

class MenuTransitionManager: NSObject {
    
    private var presenting = false
    
    func offstage(_ amount: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(translationX: amount, y: 0)
    }
    
    func offStageMenuController(_ menuViewController: MenuViewController) {
        if !presenting {
            menuViewController.view.alpha = 0
        }
        let topRowOffset : CGFloat = 300
        let middleRowOffset : CGFloat = 150
        let bottomRowOffset : CGFloat = 50
        
        menuViewController.textButton.transform = self.offstage(-topRowOffset)
        menuViewController.textLabel.transform = self.offstage(-topRowOffset)
        
        menuViewController.quoteButton.transform = self.offstage(-middleRowOffset)
        menuViewController.quoteLabel.transform = self.offstage(-middleRowOffset)
        
        menuViewController.chatButton.transform = self.offstage(-bottomRowOffset)
        menuViewController.chatLabel.transform = self.offstage(-bottomRowOffset)
        
        menuViewController.photoButton.transform = self.offstage(topRowOffset)
        menuViewController.photoLabel.transform = self.offstage(topRowOffset)
        
        menuViewController.linkButton.transform = self.offstage(middleRowOffset)
        menuViewController.linkLabel.transform = self.offstage(middleRowOffset)
        
        menuViewController.audioButton.transform = self.offstage(bottomRowOffset)
        menuViewController.audioLabel.transform = self.offstage(bottomRowOffset)
    }
    
    func onStageMenuController(_ menuViewController: MenuViewController) {
        menuViewController.view.alpha = 1
        
        menuViewController.textButton.transform = .identity
        menuViewController.textLabel.transform = .identity
        menuViewController.quoteButton.transform = .identity
        menuViewController.quoteLabel.transform = .identity
        menuViewController.chatButton.transform = .identity
        menuViewController.chatLabel.transform = .identity
        menuViewController.photoButton.transform = .identity
        menuViewController.photoLabel.transform = .identity
        menuViewController.linkButton.transform = .identity
        menuViewController.linkLabel.transform = .identity
        menuViewController.audioButton.transform = .identity
        menuViewController.audioLabel.transform = .identity
    }

}

extension MenuTransitionManager: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
}

extension MenuTransitionManager: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        let screens: (from:UIViewController, to:UIViewController) = (transitionContext.viewController(forKey: .from)!, transitionContext.viewController(forKey: .to)!)
        
        let menuViewController = self.presenting ? (screens.to as! MenuViewController) : (screens.from as! MenuViewController)
        let bottomViewController = self.presenting ? (screens.from ) : (screens.to)
        
        let menuView: UIView! = menuViewController.view
        let bottomView: UIView! = bottomViewController.view
        
        if presenting {
            self.offStageMenuController(menuViewController)
        }
        
        container.addSubview(bottomView)
        container.addSubview(menuView)
        
        let durition = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: durition, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            if (self.presenting) {
                 self.onStageMenuController(menuViewController)
            } else {
                self.offStageMenuController(menuViewController)
            }
        }) { (_) in
            transitionContext.completeTransition(true)
            
            var window : UIWindow? = nil
           
            if #available(iOS 13.0, *) {
                
                for scene in UIApplication.shared.connectedScenes {
                    if scene.activationState == .foregroundActive {
                        let wScene = scene as! UIWindowScene
                        window = wScene.windows.first!
                        break
                    }
                }
            } else {
                window = UIApplication.shared.keyWindow!
            }
            
            window!.addSubview(screens.to.view)
        }
        
    }
    
    
}
