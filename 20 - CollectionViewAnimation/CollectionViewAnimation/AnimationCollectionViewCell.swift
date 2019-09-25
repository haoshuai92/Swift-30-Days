//
//  AnimationCollectionViewCell.swift
//  CollectionViewAnimation
//
//  Created by Shuai Hao on 2019/9/24.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

class AnimationCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var animationImageView: UIImageView!
    @IBOutlet weak var animationTextView: UITextView!
    
    var backButtonTapped: (() -> Void)?
    
    func prepareCell(_ viewModel: AnimationCellModel) {
        animationImageView.image = UIImage(named: viewModel.imagePath)
        animationTextView.isScrollEnabled = false
        backButton.isHidden = true
        addTapEventHandler()
    }
    
    func handleCellSelected() {
        animationTextView.isScrollEnabled = false
        backButton.isHidden = false
        self.superview?.bringSubviewToFront(self)
    }
    
    private func addTapEventHandler() {
        backButton.addTarget(self, action: #selector(backButtonDidTouch(_:)), for: .touchUpInside)
    }
    
    @objc func backButtonDidTouch(_ sender : UIGestureRecognizer) {
        backButtonTapped?()
    }

}
