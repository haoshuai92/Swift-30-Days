//
//  AnimationImageCollection.swift
//  CollectionViewAnimation
//
//  Created by Shuai Hao on 2019/9/24.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

struct AnimationImageCollection {
    private let imagePaths = ["1", "2", "3", "4", "5"]
    var images: [AnimationCellModel]
    
    init() {
        images = imagePaths.map{AnimationCellModel(imagePath: $0)}
    }
}
