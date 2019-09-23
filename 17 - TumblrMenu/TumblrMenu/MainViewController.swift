//
//  MainViewController.swift
//  TumblrMenu
//
//  Created by Shuai Hao on 2019/9/23.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true;
        
    }
    
    @IBAction func unwindToMainViewController (_ sender: UIStoryboardSegue){
        self.dismiss(animated: true, completion: nil)
    }
    



}
