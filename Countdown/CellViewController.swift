//
//  CellViewController.swift
//  Countdown
//
//  Created by 齋藤就元 on 2021/02/13.
//  Copyright © 2021 Saito Syugen. All rights reserved.
//

import UIKit
class CellViewcontroller:UIViewController, UITableViewDataSource,UITableViewDelegate{
    @IBOutlet var table: UITableView!
    var hoge = [String]()
    var huga = [String]()
    var saveData: UserDefaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        hoge = saveData.object(forKey: "Title") as! [String]
        huga = saveData.object(forKey: "Array") as! [String]
    }
    override func didReceiveMemoryWarning() {
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hoge.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        let labelforTF = cell?.viewWithTag(1) as! UILabel
        let labelforTV = cell?.viewWithTag(2) as! UILabel
        labelforTF.text = hoge[indexPath.row]
        labelforTV.text = huga[indexPath.row]
        return cell!
    }
    
    
}
