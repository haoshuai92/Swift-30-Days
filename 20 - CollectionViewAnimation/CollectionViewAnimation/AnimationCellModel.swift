//
//  AnimationCellModel.swift
//  CollectionViewAnimation
//
//  Created by Shuai Hao on 2019/9/24.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

class AnimationCellModel: NSObject {
    
    let imagePath : String
    
    init(imagePath : String?) {
        self.imagePath = imagePath ?? ""
    }
}
