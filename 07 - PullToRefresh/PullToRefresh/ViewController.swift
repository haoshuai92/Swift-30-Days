//
//  ViewController.swift
//  PullToRefresh
//
//  Created by Shuai Hao on 2019/2/28.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var index = 0
    let emojiCellIdentifier = "EmojiCellIdentifier"
    
    let favoriteEmoji = ["🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆"]
    let newFavoriteEmoji = ["🏃🏃🏃🏃🏃", "💩💩💩💩💩", "👸👸👸👸👸", "🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆" ]
    var emojiData = [String]()
    var tableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    var navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: UIScreen.main.bounds.size.width, height: 44))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        setupNavi()
        
        setupRefresh()
        
        emojiData = favoriteEmoji
        
    }
    
    fileprivate func setupNavi() {
        navBar.barStyle = .black
        navBar.isTranslucent = true
        view.addSubview(navBar)
        navBar.delegate = self
    }
    
    fileprivate func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
//        tableView.backgroundColor = UIColor(red:0.092, green:0.096, blue:0.116, alpha:1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60.0
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: emojiCellIdentifier)
        tableView.refreshControl = refreshControl
        extendedLayoutIncludesOpaqueBars = true;
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = UIEdgeInsets.init(top: (UIApplication.shared.statusBarFrame.height + 44), left: 0, bottom: 0, right: 0)
        view.addSubview(tableView)
    }
    
    fileprivate func setupRefresh() {
        self.refreshControl.backgroundColor = UIColor(red:0.113, green:0.113, blue:0.145, alpha:1)
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.refreshControl.attributedTitle = NSAttributedString(string: "Last updated on \(Date())", attributes: attributes)
        self.refreshControl.tintColor = UIColor.white
        
        self.refreshControl.addTarget(self, action: #selector(didRoadEmoji), for: .valueChanged)
    }
    
    @objc fileprivate func didRoadEmoji() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.emojiData = [self.newFavoriteEmoji, self.favoriteEmoji][self.index]
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            self.index = (self.index + 1) % 2
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return emojiData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: emojiCellIdentifier, for: indexPath)
        cell.textLabel?.text = self.emojiData[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 50)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        return cell
    }
}

extension ViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

