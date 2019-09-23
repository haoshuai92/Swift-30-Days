//
//  MenuViewController.swift
//  TumblrMenu
//
//  Created by Shuai Hao on 2019/9/23.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    let transitionManager = MenuTransitionManager()
    
    @IBOutlet weak var textButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var photoLabel: UILabel!
    
    @IBOutlet weak var quoteButton: UIButton!
    @IBOutlet weak var quoteLabel: UILabel!
    
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var linkLabel: UILabel!
    
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var chatLabel: UILabel!
    
    @IBOutlet weak var audioButton: UIButton!
    @IBOutlet weak var audioLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitioningDelegate = transitionManager

        // Do any additional setup after loading the view.
    }
    


    
    
}
