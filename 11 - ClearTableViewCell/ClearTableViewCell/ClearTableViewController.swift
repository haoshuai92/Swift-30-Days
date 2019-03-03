//
//  ClearTableViewController.swift
//  ClearTableViewCell
//
//  Created by Shuai Hao on 2019/3/3.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

class ClearTableViewController: UITableViewController {
    
    var tableData = ["Read 3 article on Medium", "Cleanup bedroom", "Go for a run", "Hit the gym", "Build another swift project", "Movement training", "Fix the layout problem of a client project", "Write the experience of #30daysSwift", "Inbox Zero", "Booking the ticket to Chengdu", "Test the Adobe Project Comet", "Hop on a call to mom"]
//    var tableData = ["Read 3 article on Medium", "Cleanup bedroom"]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(ClearTableViewCell.self, forCellReuseIdentifier: "ClearTableViewCellIdentifier")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tableData.count
    }
    
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClearTableViewCellIdentifier") as! ClearTableViewCell
        
        cell.textLabel?.text = tableData[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.textLabel?.backgroundColor = .clear
        cell.textLabel?.font = UIFont(name: "Avenir Next", size: 18)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func colorForIndex(index: Int) -> UIColor {
        let itemCOunt = tableData.count - 1
        let color = (CGFloat(index) / CGFloat(itemCOunt)) * 0.6
        
        return UIColor(red: 1.0, green: color, blue: 0.0, alpha: 1.0)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = colorForIndex(index: indexPath.row)
    }
    
    

    

}
