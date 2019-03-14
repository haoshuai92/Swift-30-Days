//
//  CustomPresentationController.swift
//  SlideMenu
//
//  Created by Shuai Hao on 2019/3/11.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController {
    
    var presentationWrappingView: UIView?
    var dimmingView: UIView?
    var isPresenting: Bool = false
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?)
    {
        super.init(presentedViewController: presentedViewController, presenting: presentedViewController)
        presentedViewController.modalPresentationStyle = .custom
    
    }
    
    override var presentedView: UIView?
    {
        return presentationWrappingView
    }
    
    override func presentationTransitionWillBegin()
    {
        let presentedViewControllerView = super.presentedView
        
        let presentationWrapperView = UIView.init(frame:self.frameOfPresentedViewInContainerView)
        presentationWrapperView.layer.shadowOpacity = 0.44
        presentationWrapperView.layer.shadowOpacity = 13.0
        presentationWrapperView.layer.shadowOffset = CGSize(width: 0, height: -6.0)
        presentationWrappingView = presentationWrapperView
        
        let presentationRoundedCornerView = UIView.init(frame: presentationWrapperView.bounds.inset(by: UIEdgeInsets.init(top: 0, left: 0, bottom: 16.0, right: 0)))
        presentationRoundedCornerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        presentationRoundedCornerView.layer.cornerRadius = 16.0
        presentationRoundedCornerView.layer.masksToBounds = true
        
        let presentedViewControllerWrapperView = UIView.init(frame: presentationWrapperView.bounds.inset(by: UIEdgeInsets.init(top: 0, left: 0, bottom: 16.0, right: 0)))
        presentedViewControllerWrapperView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        presentedViewControllerView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        presentedViewControllerView?.frame = presentationWrapperView.bounds
        presentedViewControllerWrapperView.addSubview(presentedViewControllerView!)
        
        presentationRoundedCornerView.addSubview(presentedViewControllerWrapperView)
        
        presentationWrapperView.addSubview(presentationRoundedCornerView)
        
        let dimmingView = UIView.init(frame: self.containerView!.bounds)
        dimmingView.backgroundColor = .black
        dimmingView.isOpaque = false
        dimmingView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        dimmingView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(dimmingViewTapped)))
        self.dimmingView = dimmingView
        self.containerView?.addSubview(dimmingView)
        
        self.dimmingView?.alpha = 0.0
        self.presentingViewController.transitionCoordinator?.animate(alongsideTransition: { (context) in
            self.dimmingView?.alpha = 0.5
        }, completion: nil)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool)
    {
        if completed == false
        {
            self.presentationWrappingView = nil
            self.dimmingView = nil
        }
    }
    
    override func dismissalTransitionWillBegin()
    {
        self.presentingViewController.transitionCoordinator?.animate(alongsideTransition: { (context) in
            self.dimmingView?.alpha = 0.0
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool)
    {
        if completed == true
        {
            self.presentationWrappingView = nil
            self.dimmingView = nil
        }
    }
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer)
    {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        
        if self.presentedViewController == container as? UIViewController
        {
            self.containerView?.setNeedsLayout()
        }
        
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize
    {
        if self.presentedViewController == container as? UIViewController
        {
            return self.presentedViewController.preferredContentSize
        }
        else
        {
            return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect
    {
        let containerViewBounds = self.containerView!.bounds
        let presentedViewContentSize = self.size(forChildContentContainer: self.presentedViewController, withParentContainerSize: containerViewBounds.size)
        
        var presentedViewFrame = containerViewBounds
        presentedViewFrame.size.height = presentedViewContentSize.height
        presentedViewFrame.origin.y = containerViewBounds.maxY - presentedViewContentSize.height
        return presentedViewFrame
    }
    
    override func containerViewWillLayoutSubviews()
    {
        super.containerViewWillLayoutSubviews()
        self.dimmingView?.frame = self.containerView!.bounds
        self.presentationWrappingView?.frame = self.frameOfPresentedViewInContainerView
    }
    
    @objc func dimmingViewTapped()
    {
        self.presentingViewController.dismiss(animated: true, completion: nil)
    }

}

extension CustomPresentationController: UIViewControllerAnimatedTransitioning
{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return transitionContext!.isAnimated ? 5 : 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        let fromVc = transitionContext.viewController(forKey: .from)!
        let toVc = transitionContext.viewController(forKey: .to)!
        let fromView = transitionContext.view(forKey: .from)
        let toView = transitionContext.view(forKey: .to)
        let containerView = transitionContext.containerView
        
        var fromViewFinalFrame = transitionContext.finalFrame(for: fromVc)
        var toViewInitialFrame = transitionContext.initialFrame(for: toVc)
        var toViewFinalFrame = transitionContext.finalFrame(for: toVc)
        
        
        
        if self.isPresenting
        {
            
            toViewInitialFrame.origin = CGPoint(x: containerView.bounds.minX, y: UIApplication.shared.statusBarFrame.height + 44)
            toViewInitialFrame.size = CGSize(width: toViewFinalFrame.width, height: 0)
            toViewFinalFrame.size = CGSize(width: toViewFinalFrame.width, height: 420)
            toViewFinalFrame.origin = CGPoint(x: containerView.bounds.minX, y: UIApplication.shared.statusBarFrame.height + 44)
            
            containerView.addSubview(toView!)
        }
        else
        {
            fromViewFinalFrame = fromView!.frame.offsetBy(dx: 0, dy: fromView!.frame.height)
        }
        
        let transitionDuration = self.transitionDuration(using: transitionContext)
        
            
        if self.isPresenting
        {
            toView!.frame = toViewInitialFrame
        }
        else
        {
            fromView!.frame = fromViewFinalFrame
        }
        
        UIView.animate(withDuration: transitionDuration, animations: {
            if self.isPresenting
            {
                toView!.frame = toViewFinalFrame
            }
            else
            {
                fromView!.frame = fromViewFinalFrame
            }
        }) { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        
    }
    

}

extension CustomPresentationController: UIViewControllerTransitioningDelegate
{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return self;
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresenting = false
        return self
    }
    
}


