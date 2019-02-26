//
//  IntersetCell.swift
//  Carousel Effect
//
//  Created by Shuai Hao on 2019/2/26.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

class IntersetCell: UICollectionViewCell {
    
    @IBOutlet weak var featuredImgView: UIImageView!
    @IBOutlet weak var interestTitleLabel: UILabel!
    
    var interest: Interest! {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        interestTitleLabel?.text! = interest.title
        featuredImgView?.image! = interest.featuredImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
    
    
    
}
