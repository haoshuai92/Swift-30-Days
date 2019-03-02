//
//  ViewController.swift
//  ImageScrollerEffect
//
//  Created by Shuai Hao on 2019/3/2.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    fileprivate func updateMinZoomScaleForSize(_ size: CGSize){
        //要获得最小的缩放比例，首先计算所需的缩放比例，以便根据其宽度在scrollView中紧贴imageView

        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        //选取宽度和高度比例中最小的那个,设置为minimumZoomScale
        let minScale = min(widthScale,heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 3.0
        scrollView.zoomScale = minScale
    }
    
    fileprivate func updateConstraintsForSize(_ size: CGSize){
        
        let yOffset = max(0, (size.height - imageView.frame.height) * 0.5)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        
        view.layoutIfNeeded()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // 适配横屏
        imageView.frame = CGRect.init(x: imageView.frame.origin.x, y: imageView.frame.origin.y, width: imageView.frame.size.width-1, height: imageView.frame.size.height-1)
    }
    

}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
