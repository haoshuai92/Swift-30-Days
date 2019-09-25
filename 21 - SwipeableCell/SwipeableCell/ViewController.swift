//
//  ViewController.swift
//  SwipeableCell
//
//  Created by Shuai Hao on 2019/9/25.
//  Copyright © 2019 Shuai Hao. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let data = [
        pattern(name:"Pattern Building", image:"1"),
        pattern(name: "Joe Beez", image: "2"),
        pattern(name: "Car It's car", image: "3"),
        pattern(name: "Floral Kaleidoscopic", image: "4"),
        pattern(name: "Sprinkle Pattern", image: "5"),
        pattern(name: "Palitos de queso", image: "6"),
        pattern(name: "Ready to Go? Pattern", image: "7"),
        pattern(name: "Sets Seamless", image: "8"),
    
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PatternCellIdentifier", for: indexPath) as! PatternCell
        let pattern = data[indexPath.row]
        
        cell.patternImageView.image = UIImage(named: pattern.image)
        cell.patternLabel.text = pattern.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "🗑\nDelete") { (action, view, _) in
            print("Delete button tapped")
        }
        delete.backgroundColor = .gray
        
        let share = UIContextualAction(style: .normal, title: "🤗\nShare") { (action, view, _) in
            let firstActivityItem = self.data[indexPath.row]
            let activityViewController = UIActivityViewController(activityItems: [firstActivityItem.image as NSString], applicationActivities: nil)
            
            self.present(activityViewController, animated: true, completion: nil)
        }
        share.backgroundColor = .red
        
        let download = UIContextualAction(style: .normal, title: "⬇️\nDownload") { (action, view, _) in
            print("Delete button tapped")
        }
        download.backgroundColor = .blue
        
        
        return UISwipeActionsConfiguration(actions: [download, share, delete])
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            print("Delete")
        case .insert:
            print("Insert")
        case .none:
            print("None")
        default:
            print("deflult")
        }
    }
}

