//
//  ViewController.swift
//  StopWatch
//
//  Created by Shuai Hao on 2019/2/22.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var beginButton: UIButton!
    @IBOutlet weak var pauseButon: UIButton!
    
    var counter = 0.0 {
        didSet{
            timeLabel.text = String(format: "%.1f", counter)
        }
    }
    
    var timer : Timer? = Timer()
    
    var isPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        counter = 0.0
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    deinit {
        print("deinit")
    }


    @IBAction func beginButtonDidTouch(_ sender: UIButton) {
        beginButton.isEnabled = false
        pauseButon.isEnabled = true
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.UpdateTimer), userInfo: nil, repeats: true)
        isPlaying = true
    }
    
    @IBAction func pauseButtonDidTouch(_ sender: UIButton) {
        beginButton.isEnabled = true
        pauseButon.isEnabled = false
        if let timerTemp = timer {
            timerTemp.invalidate()
        }
        timer = nil
        isPlaying = false
    }
    
    @IBAction func resetButtonDidTouch(_ sender: UIButton) {
        
        if let timerTemp = timer {
            timerTemp.invalidate()
        }
        counter = 0
        timer = nil
        beginButton.isEnabled = true
        pauseButon.isEnabled = true
        isPlaying = false
    }
    
    @objc func UpdateTimer() {
        counter += 0.1
    }
    
}

