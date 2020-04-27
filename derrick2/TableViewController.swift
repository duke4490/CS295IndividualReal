//
//  TableViewController.swift
//  derrick2
//
//  Created by Derrick on 4/21/20.
//  Copyright © 2020 derrick-temp. All rights reserved.
//

import Foundation
import UIKit

var userDefaults = UserDefaults.standard.dictionaryRepresentation() as NSDictionary

var data = [Dictionary<String, String>()]

class TableViewController: UITableViewController {
    
    
    @IBAction func addCell(_ sender: Any) {
        data.append(["device":"Brand","serial":"Model","value":"$Price"])
        
        tableView.reloadData()
        
        updateDefaults()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
//        let rightButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItem.Style.plain, target: self, action: #selector("showEditing:")))
//        self.navigationItem.rightBarButtonItem = rightButton
        
        if (UserDefaults.standard.array(forKey: "data") == nil) {
            UserDefaults.standard.set([["device":"iPhone","serial":"99220022","value":"$9999"]], forKey: "data")
        } else {
            data = UserDefaults.standard.array(forKey: "data") as! [Dictionary<String, String>]
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        updateDefaults()
    }
    
    func updateDefaults() {
        UserDefaults.standard.removeObject(forKey: "data")
        
        UserDefaults.standard.set(data, forKey: "data")
    }
    
//    func showEditing(sender: UIBarButtonItem)
//     {
//        if(self.tableView.isEditing == true)
//        {
//            self.tableView.isEditing = false
//            self.navigationItem.rightBarButtonItem?.title = "Done"
//        }
//        else
//        {
//            self.tableView.isEditing = true
//            self.navigationItem.rightBarButtonItem?.title = "Edit"
//        }
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        updateDefaults()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
//            //TODO: edit the row at indexPath here
//        }
//        editAction.backgroundColor = .blue
//
//        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
//            //TODO: Delete the row at indexPath here
//        }
//        deleteAction.backgroundColor = .red
//
//        return [editAction,deleteAction]
//    }
//
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
//        let defaults = userDefaults.value(forKey: "data")! as! Array<Any>
        let curr_val = data[indexPath.row]
        
        cell.detailTextLabel?.text = curr_val["value"]
        cell.textLabel?.text = curr_val["device"]
        
        let subLabel = UILabel.init(frame: CGRect(x: 10, y: 80, width: 100, height: 20))
        
        subLabel.text = curr_val["serial"]
        
        cell.addSubview(subLabel)
        
        return cell;
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "detailView") as! DetailViewController
        nextVC.subdata = data[indexPath.row]
        nextVC.subindex = indexPath.row
        nextVC.tableView = tableView
        
        updateDefaults()

        self.present(nextVC, animated: true, completion: nil)
    }

}
