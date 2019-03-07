//
//  MenuTrasitionManager.swift
//  SlideMenu
//
//  Created by Shuai Hao on 2019/3/7.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

@objc protocol MenuTrasitionManagerDelegate {
    @objc func dismiss();
}

class MenuTrasitionManager: NSObject {
    
    var duration = 0.5
    var isPresenting = false
    weak var delegate: MenuTrasitionManagerDelegate?
    
    var snapshot: UIView? {
        didSet {
            guard let delegate = delegate else {
                return
            }
            let tapGestureRecognizer  = UITapGestureRecognizer(target: delegate, action: #selector(MenuTrasitionManagerDelegate.dismiss))
            snapshot?.addGestureRecognizer(tapGestureRecognizer)
        }
    }

}

extension MenuTrasitionManager: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        let container = transitionContext.containerView
        let moveLeft = CGAffineTransform(translationX: 250, y: 0)
        let moveRight = CGAffineTransform(translationX: 0, y: 0)
        
        if isPresenting {
            snapshot = fromView.snapshotView(afterScreenUpdates: true)
            container.addSubview(toView)
            container.addSubview(snapshot!)
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: .curveEaseInOut, animations: {
            if self.isPresenting {
                self.snapshot?.transform = moveLeft
                toView.transform = moveRight
            } else {
                self.snapshot?.transform = .identity
                fromView.transform = moveRight
            }
        }) { (_) in
            transitionContext.completeTransition(true)
            if !self.isPresenting {
                self.snapshot?.removeFromSuperview()
            }
        }
    }
    
    
}

extension MenuTrasitionManager: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
}
