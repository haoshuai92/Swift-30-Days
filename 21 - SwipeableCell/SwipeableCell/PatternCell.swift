//
//  PatternCell.swift
//  SwipeableCell
//
//  Created by Shuai Hao on 2019/9/25.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

struct pattern {
    let name: String
    let image: String
}

class PatternCell: UITableViewCell {
    
    @IBOutlet weak var patternImageView: UIImageView!
    @IBOutlet weak var patternLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
