//
//  ViewController.swift
//  SpotifyVideoBackground
//
//  Created by Shuai Hao on 2019/3/2.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

class ViewController: VideoSplashViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 4
        signUpButton.layer.cornerRadius = 4
        
        setupVideoBackground()
    }
    
    func setupVideoBackground() {
        
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "moments", ofType: "mp4")!)
        videoFrame = view.frame
        fillMode = .resizeAspectFill
        alwaysRepeat = true
        sound = true
        startTime = 2.0
        duration = 5.0
        alpha = 0.8
        
        contentURL = url
        
        
    }


}

