//
//  DetailViewController.swift
//  derrick2
//
//  Created by Derrick on 4/21/20.
//  Copyright © 2020 derrick-temp. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {

    var subdata = Dictionary<String, String>()
    var subindex = Int()
    var tableView = UITableView()
    
    @IBOutlet weak var deviceName: UITextField!
    @IBOutlet weak var deviceSerial: UITextField!
    @IBOutlet weak var deviceValue: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deviceName.text = subdata["device"]
        deviceSerial.text = subdata["serial"]
        deviceValue.text = subdata["value"]
        
        
    }
    @IBAction func removeValue(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        data.remove(at: subindex)
        tableView.reloadData()
    }
    @IBAction func updateName(_ sender: Any) {
        data[subindex]["device"] = deviceName.text
        tableView.reloadData()
    }
    @IBAction func updateSerial(_ sender: Any) {
        data[subindex]["serial"] = deviceSerial.text
        tableView.reloadData()
    }
    @IBAction func updateValue(_ sender: Any) {
        data[subindex]["value"] = deviceValue.text
        tableView.reloadData()
    }
    
}
