//
//  MenuTableViewController.swift
//  SlideMenu
//
//  Created by Shuai Hao on 2019/3/7.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

@objc protocol MenuTableViewControllerDelegate {
    
    
    /// 菜单控制器代理
    ///
    /// - Parameters:
    ///   - viewController: 菜单控制器
    ///   - item: 选择的某个选项
    func menuTableViewController(_ viewController: MenuTableViewController, didSelected item: String?);
}

class MenuTableViewController: UITableViewController {
    
    weak var delegate: MenuTableViewControllerDelegate?
    var menuItems = ["Everyday Moments", "Popular", "Editors", "Upcoming", "Fresh", "Stock-photos", "Trending"]
    var currentItem = "Everyday Moments"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red:0.109, green:0.114, blue:0.128, alpha:1)
        tableView.separatorStyle = .none
        
        self.preferredContentSize = CGSize(width: self.view.bounds.size.width, height: 420)
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    deinit {
        print("deinit")
    }
    
    
}

extension MenuTableViewController {
    // MARK: UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCellIdentifier", for: indexPath) as! MenuTableViewCell
        
        cell.menuTitle.text = menuItems[indexPath.row]
        cell.menuTitle.textColor = (menuItems[indexPath.row] == currentItem) ? UIColor.white : UIColor.gray
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = delegate else {
            return
        }
        let title = menuItems[indexPath.row]
        delegate.menuTableViewController(self, didSelected: title)
    }
}
