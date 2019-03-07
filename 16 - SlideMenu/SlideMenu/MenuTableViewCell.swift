//
//  MenuTableViewCell.swift
//  SlideMenu
//
//  Created by Shuai Hao on 2019/3/7.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
