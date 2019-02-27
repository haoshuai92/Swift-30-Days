//
//  ViewController.swift
//  Where
//
//  Created by Shuai Hao on 2019/2/27.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    
    var locationManager: CLLocationManager? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
    }

    @IBAction func findLocationButtonDidTouch(_ sender: UIButton) {
        
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        
    }
    
}

