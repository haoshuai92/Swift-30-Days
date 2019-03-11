//
//  CustomPresentationController.swift
//  SlideMenu
//
//  Created by Shuai Hao on 2019/3/11.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController, UIViewControllerTransitioningDelegate {
    
    var presentationWrappingView: UIView?
    var dimmingView: UIView?
    
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
        
        
    }

    

}
