//
//  ViewController.swift
//  CustomFont
//
//  Created by Shuai Hao on 2019/2/22.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let identifier = "FontCell"
    
    var data = ["30 Days Swift",
                "这些字体特别适合打「奋斗」和「理想」",
                "谢谢「造字工房」，本案例不涉及商业使用",
                "使用到造字工房劲黑体，致黑体，童心体",
                "呵呵，再见🤗 See you next Project",
                "微博 @Allen朝辉",
                "测试测试测试测试测试测试",
                "123",
                "Alex",
                "@@@@@@"]
    // 需要在info.plist 里添加 Fonts provided by application 字段
    var fontNames = ["MFTongXin_Noncommercial-Regular",
                     "MFJinHei_Noncommercial-Regular",
                     "MFZhiHei_Noncommercial-Regular",
                     "Zapfino",
                     "Gaspar Regular"]
    
    var fontRowIndex = 0

    @IBOutlet weak var changeFontLabel: UILabel!
    @IBOutlet weak var fontTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        changeFontLabel.layer.cornerRadius = 50
        changeFontLabel.layer.masksToBounds = true
        // 给label添加手势
        changeFontLabel.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(changeFontDidTouch(_:)))
        changeFontLabel.addGestureRecognizer(gesture)
    }
    
    @objc func changeFontDidTouch(_ sender: AnyObject) {
        fontRowIndex = (fontRowIndex + 1) % 5
        print(fontNames[fontRowIndex])
        fontTableView.reloadData()
    }

    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = fontTableView.dequeueReusableCell(withIdentifier: ViewController.identifier, for: indexPath)
        let text = data[indexPath.row]
        
        cell.textLabel?.text = text
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: self.fontNames[fontRowIndex], size: 16)
        
        return cell
        
    }

}

