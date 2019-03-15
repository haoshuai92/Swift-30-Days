//
//  NewsTableViewController.swift
//  SlideMenu
//
//  Created by Shuai Hao on 2019/3/7.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Everyday Moments"
        view.backgroundColor = UIColor(red: 0.062, green: 0.062, blue: 0.007, alpha: 1)
        tableView.separatorStyle = .none
    }
    
    @IBAction func buttonAction(_ sender: UIBarButtonItem) {
        guard let menuVc = (self.storyboard?.instantiateViewController(withIdentifier: "MenuTableViewController") as? MenuTableViewController) else { return }
        let customPresentationController = CustomPresentationController.init(presentedViewController: menuVc, presenting: self)
        menuVc.transitioningDelegate = customPresentationController
        menuVc.delegate = self
        menuVc.currentItem = self.title ?? ""
        self.present(menuVc, animated: true, completion: nil)
        
    }
    

}

extension NewsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCellIdentifier", for: indexPath) as! NewsTableViewCell
        
        if indexPath.row == 0 {
            cell.postImageView.image = UIImage(named: "1")
            cell.postTitle.text = "Love mountain."
            cell.postAuthor.text = "Allen Wang"
            cell.authorImageView.image = UIImage(named: "a")
            
        } else if indexPath.row == 1 {
            cell.postImageView.image = UIImage(named: "2")
            cell.postTitle.text = "New graphic design - LIVE FREE"
            cell.postAuthor.text = "Cole"
            cell.authorImageView.image = UIImage(named: "b")
            
        } else if indexPath.row == 2 {
            cell.postImageView.image = UIImage(named: "3")
            cell.postTitle.text = "Summer sand"
            cell.postAuthor.text = "Daniel Hooper"
            cell.authorImageView.image = UIImage(named: "c")
            
        } else {
            cell.postImageView.image = UIImage(named: "4")
            cell.postTitle.text = "Seeking for signal"
            cell.postAuthor.text = "Noby-Wan Kenobi"
            cell.authorImageView.image = UIImage(named: "d")
            
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240.0
    }
    
    
}



extension NewsTableViewController: MenuTableViewControllerDelegate {
    func menuTableViewController(_ viewController: MenuTableViewController, didSelected item: String?) {
        title = item
        dismiss(animated: true, completion: nil)
    }
}
