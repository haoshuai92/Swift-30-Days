//
//  ViewController.swift
//  Snapchat Menu
//
//  Created by Shuai Hao on 2019/2/25.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let leftVc: UIViewController = LeftViewController(nibName: "LeftViewController", bundle: nil)
        let centerVc: CameraViewController = CameraViewController(nibName: "CameraViewController", bundle: nil)
        let rightVc: RightViewController = RightViewController(nibName: "RightViewController", bundle: nil)
        
        leftVc.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        centerVc.view.frame = CGRect(x: screenWidth, y: 0, width: screenWidth, height: screenHeight)
        rightVc.view.frame = CGRect(x: 2*screenWidth, y: 0, width: screenWidth, height: screenHeight)
        leftVc.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        scrollView.frame = UIScreen.main.bounds
        scrollView.contentSize = CGSize(width: screenWidth * 3, height: screenHeight)
        scrollView.delaysContentTouches = false;
        scrollView.addSubview(leftVc.view)
        scrollView.addSubview(centerVc.view)
        scrollView.addSubview(rightVc.view)
        // 如果不添加子控制器的话,会出现按钮无法响应的情况
        self.addChild(leftVc)
        self.addChild(centerVc)
        self.addChild(rightVc)
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}



